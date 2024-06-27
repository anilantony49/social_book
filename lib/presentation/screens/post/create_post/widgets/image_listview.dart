import 'package:flutter/material.dart';
import 'package:social_book/core/utils/app_icons.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class ImageListview extends StatefulWidget {
  final List<AssetEntity> selectedAssetList;
  const ImageListview({
    super.key,
    required this.selectedAssetList,
  });

  @override
  State<ImageListview> createState() => _ImageListviewState();
}

class _ImageListviewState extends State<ImageListview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10,top: 10),
      height: 130,
      width: double.infinity,
      color: Theme.of(context).colorScheme.surface,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: widget.selectedAssetList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            AssetEntity assetEntity = widget.selectedAssetList[index];
            return Container(
              margin: const EdgeInsets.only(left: 15),
              width: 90,
              child: Stack(
                children: [
                  Positioned.fill(
                      child: GestureDetector(
                    onTap: () async {
                      await AssetPickerViewer.pushToViewer(context,
                          previewAssets: widget.selectedAssetList,
                          themeData: Theme.of(context));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: AssetEntityImage(
                        assetEntity,
                        isOriginal: false,
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
                  )),

                   Positioned(
                  top: 5,
                  right: 5,
                  child: GestureDetector(
                    onTap: () {
                      if (widget.selectedAssetList.contains(assetEntity)) {
                        setState(() {
                          widget.selectedAssetList.remove(assetEntity);
                        });
                      }
                    },
                    child: const CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      child: Icon(
                        AppIcons.close,
                        size: 15,
                      ),
                    ),
                  ),
                ),
                ],
              ),
            );
          }),
    );
  }
}
