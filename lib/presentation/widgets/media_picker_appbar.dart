// ignore_for_file: deprecated_member_use

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_book/core/utils/app_icons.dart';
import 'package:social_book/core/utils/constants.dart';

class MediaPickerAppbar extends StatefulWidget {
  const MediaPickerAppbar({
    super.key,
    required this.selectedAssetList,
    required this.albumList,
    required this.selectedAlbum,
    required this.onChanged,
    required this.onPressed,
  });

  final List<AssetEntity> selectedAssetList;
  final List<AssetPathEntity> albumList;
  final AssetPathEntity? selectedAlbum;
  final void Function(AssetPathEntity?)? onChanged;
  final void Function()? onPressed; 

  @override
  State<MediaPickerAppbar> createState() => _MediaPickerAppbarState();
}

class _MediaPickerAppbarState extends State<MediaPickerAppbar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MediaAppbar(
          onPressed: widget.onPressed,
          selectedAssetList: widget.selectedAssetList,
        ),
        const SizedBox(
          height: 10,
        ),
        _mediaDropdown(),
      ],
    );
  }

  DropdownButtonHideUnderline _mediaDropdown() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<AssetPathEntity>(
        isDense: true,
        isExpanded: false,
        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.symmetric(horizontal: 15),
          height: 40,
        ),
        iconStyleData: IconStyleData(
          icon: Icon(
            AppIcons.arrow_down_ios,
            size: 15,
            color: Theme.of(context).colorScheme.primary,
          ),
          iconSize: 18,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 300,
          width: double.infinity,
          elevation: 2,
          decoration:
              BoxDecoration(color: Theme.of(context).colorScheme.surface),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all(6),
            thumbVisibility: MaterialStateProperty.all(true),
          ),
        ),
        value: widget.selectedAlbum,
        onChanged: widget.onChanged,
        items: widget.albumList
            .map<DropdownMenuItem<AssetPathEntity>>((AssetPathEntity album) {
          return DropdownMenuItem<AssetPathEntity>(
            value: album,
            child: FutureBuilder<int>(
              future: album.assetCountAsync,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(album.name);
                } else {
                  return Text(album.name);
                }
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}

class MediaAppbar extends StatelessWidget {
  const MediaAppbar({
    super.key,
    this.selectedAssetList,
    this.onPressed,
  });

  final List<AssetEntity>? selectedAssetList;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 40,
      automaticallyImplyLeading: false,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          AppIcons.close,
          size: 26,
        ),
      ),
      titleSpacing: 0,
      centerTitle: true,
      title: const Text(
        'Select Media',
        style: TextStyle(fontSize: 18, fontVariations: fontWeightW600),
      ),
      actions: [
        selectedAssetList != null && selectedAssetList!.isNotEmpty
            ? IconButton(
                onPressed: onPressed,
                icon: const Icon(
                  AppIcons.arrow_right,
                  size: 22,
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
