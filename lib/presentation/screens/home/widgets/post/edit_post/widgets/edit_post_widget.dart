import 'package:flutter/material.dart';
import 'package:social_book/core/utils/app_icons.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class EditImageListview extends StatefulWidget {
  final List imageUrlList;
  const EditImageListview({
    super.key,
    required this.imageUrlList,
  });

  @override
  State<EditImageListview> createState() => _EditImageListviewState();
}

class _EditImageListviewState extends State<EditImageListview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      height: 130,
      width: double.infinity,
      color: Theme.of(context).colorScheme.surface,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: widget.imageUrlList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            String imageUrl = widget.imageUrlList[index];
            return Container(
              margin: const EdgeInsets.only(left: 15),
              width: 90,
              child: Stack(
                children: [
                  Positioned.fill(
                      child: GestureDetector(
                    onTap: () async {
                      // await AssetPickerViewer.pushToViewer(context,
                      //     previewAssets: widget.selectedAssetList,
                      //     themeData: Theme.of(context));
                    },
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(
                                AppIcons.info_rugged,
                                color: Colors.red,
                              ),
                            );
                          },
                        )),
                  )),
                  if (widget.imageUrlList.length != 1)
                    Positioned(
                      top: 5,
                      right: 5,
                      child: GestureDetector(
                        onTap: () {
                          if (widget.imageUrlList.contains(imageUrl)) {
                            setState(() {
                              widget.imageUrlList.remove(imageUrl);
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
