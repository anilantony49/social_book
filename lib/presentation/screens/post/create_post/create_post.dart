import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/core/utils/app_colors.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/presentation/bloc/post/post_bloc.dart';
import 'package:social_book/presentation/bloc/post_logics/post_logics_bloc.dart';
import 'package:social_book/presentation/bloc/profile/profile_bloc.dart';
import 'package:social_book/presentation/screens/post/create_post/widgets/image_listview.dart';
import 'package:social_book/presentation/widgets/custom_button.dart';
import 'package:social_book/presentation/widgets/media_picker_page.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({
    super.key,
  });

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();
  List<AssetEntity> selectedAssetList = [];
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: AppColors.lLightWhite,
      child: Scaffold(
        body: BlocListener<PostLogicsBloc, PostLogicsState>(
          listener: (context, state) {
            if (state is CreatePostSuccessState) {
              customSnackbar(
                context,
                'New post uploaded successfully',
              );
              context.read<PostBloc>().add(PostInitialFetchEvent());
              context.read<ProfileBloc>().add(ProfileInitialFetchEvent());
              locationController.clear();
              descriptionController.clear();
              setState(() {
                selectedAssetList.clear();
              });
            }
          },
          child: ListView(
            children: [
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    kHeight(15),
                    const Text(
                      'Post',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.0),
                            child: Text('Select Image(s)'))),
                    kHeight(10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 280,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    style: BorderStyle.solid, width: 2)),
                            child: ImageListview(
                                selectedAssetList: selectedAssetList),
                          ),
                          IconButton(
                              onPressed: () async {
                                final result = await nextScreen(
                                    context,
                                    const MediaPicker(
                                        maxCount: 10,
                                        requestType: RequestType.common,
                                        screenType: ScreenType.post));
                                if (result != null &&
                                    result is List<AssetEntity>) {
                                  setState(() {
                                    selectedAssetList = result;
                                  });
                                } else {
                                  const Center(
                                    child: Text('No images selected'),
                                  );
                                }
                              },
                              icon: const Icon(
                                Icons.add_box_outlined,
                                size: 40,
                              )),
                        ],
                      ),
                    ),
                    kHeight(10),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.0),
                            child: Text('Add Location'))),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        // maxLines: 5,
                        controller: locationController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: AppColors.customBtnColor, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field is required.';
                          }
                          return null;
                        },
                      ),
                    ),
                    kHeight(10),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.0),
                            child: Text('Add Caption'))),
                    kHeight(10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        maxLines: 5,
                        controller: descriptionController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: AppColors.customBtnColor, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field is required.';
                          }
                          return null;
                        },
                      ),
                    ),
                    kHeight(20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                      child: BlocBuilder<PostLogicsBloc, PostLogicsState>(
                        builder: (context, state) {
                          if (state is CreatePostLoadingState) {
                            return Container(
                              height: 15,
                              width: 15,
                              margin: const EdgeInsets.only(right: 15),
                              child: const CircularProgressIndicator(
                                color: Colors.black,
                                strokeWidth: 2,
                              ),
                            );
                          }
                          return CustomButton(
                            buttonText: 'Upload',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                context
                                    .read<PostLogicsBloc>()
                                    .add(CreatePostEvent(
                                      location: locationController.text,
                                      description: descriptionController.text,
                                      selectedAssets: selectedAssetList,
                                    ));
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
