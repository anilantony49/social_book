import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_book/core/theme/image_preview_theme.dart';
import 'package:social_book/core/utils/app_icons.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/presentation/bloc/media_picker/media_picker_bloc.dart';
import 'package:social_book/presentation/cubit/set_profile_image/cubit/set_profile_image_cubit.dart';
import 'package:social_book/presentation/widgets/media_picker_appbar.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

enum ScreenType { post, story, profile }

class MediaPicker extends StatefulWidget {
  final int maxCount;
  final RequestType requestType;
  final ScreenType screenType;
  final String? userId;
  const MediaPicker(
      {super.key,
      required this.maxCount,
      required this.requestType,
      required this.screenType,
      this.userId});

  @override
  State<MediaPicker> createState() => _MediaPickerState();
}

class _MediaPickerState extends State<MediaPicker> {
  List<AssetEntity> selectedAssetList = [];

  @override
  void initState() {
    context
        .read<MediaPickerBloc>()
        .add(LoadAlbumsAndAssetsEvent(requestType: RequestType.common));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ColorfulSafeArea(
      color: theme.colorScheme.surface,
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(90),
            child: BlocBuilder<MediaPickerBloc, MediaPickerState>(
                builder: (context, state) {
              if (state is MediaSuccessState) {
                debugPrint('Selected Album: ${state.selectedAlbum}');
                debugPrint(
                    'Length of album after selecting ${state.albumList.length}');

                return MediaPickerAppbar(
                    selectedAlbum: state.selectedAlbum ?? state.albumList[0],
                    selectedAssetList: selectedAssetList,
                    albumList: state.albumList,
                    onChanged: (AssetPathEntity? value) {
                      context.read<MediaPickerBloc>().add(
                          LoadSelectedAssetEvent(
                              selectedAlbum: value,
                              albumList: state.albumList));
                    },
                    onPressed: () {
                      if (widget.screenType == ScreenType.post) {
                      Navigator.of(context).pop(selectedAssetList);
                        // nextScreen(context, const CreatePostScreen());
                      } else if (widget.screenType == ScreenType.profile) {
                        context
                          .read<SetProfileImageCubit>()
                          .setProfileImage(selectedAssetList);
                        Navigator.of(context).pop(selectedAssetList);
                      } else if (widget.screenType == ScreenType.story) {
                        // nextScreen(context, StoryImagePreviewPage());
                      }
                    });
              }
              return const MediaAppbar();
            })),
        body: BlocBuilder<MediaPickerBloc, MediaPickerState>(
          builder: (context, state) {
            if (state is MediaSuccessState) {
              if (state.assetList.isEmpty) {
                return const Center(
                  child: Text('No albums found'),
                );
              } else {
                return GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                      physics: const BouncingScrollPhysics(),
                        itemCount: state.assetList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      AssetEntity assetEntity = state.assetList[index];
                      return Padding(
                        padding: const EdgeInsets.all(2),
                        child: assetWidget(assetEntity, state.assetList),
                      );
                    });
              }
            }
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.onPrimary,
                strokeWidth: 2,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget assetWidget(AssetEntity assetEntity, List<AssetEntity> assetList) {
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: () {
              selectAsset(assetEntity: assetEntity);
            },
            onLongPress: () async {
              debugPrint('Long press to view');
              await AssetPickerViewer.pushToViewer(
                context,
                previewAssets: assetList,
                themeData: imagePreviewlightTheme,
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: AssetEntityImage(
                assetEntity,
                isOriginal: false,
                opacity: AlwaysStoppedAnimation(
                    selectedAssetList.contains(assetEntity) == true ? 0.8 : 1),
                thumbnailSize: const ThumbnailSize.square(250),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      AppIcons.info_rugged,
                      color: Colors.red,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        if (assetEntity.type == AssetType.video)
          Positioned(
            bottom: 2,
            left: 5,
            child: Row(
              children: [
                const Icon(
                  Icons.videocam_rounded,
                  color: Colors.white,
                ),
                const SizedBox(width: 5),
                Text(
                  '${formattedTime(timeInSecond: assetEntity.duration)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                color: selectedAssetList.contains(assetEntity) == true
                    ? Colors.white
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  '${selectedAssetList.indexOf(assetEntity) + 1}',
                  style: TextStyle(
                    color: selectedAssetList.contains(assetEntity) == true
                        ? Colors.black
                        : Colors.transparent,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  void selectAsset({required AssetEntity assetEntity}) {
    if (selectedAssetList.contains(assetEntity)) {
      setState(() {
        selectedAssetList.remove(assetEntity);
      });
    } else if (selectedAssetList.length < widget.maxCount) {
      setState(() {
        selectedAssetList.add(assetEntity);
      });
    }
  }
}
