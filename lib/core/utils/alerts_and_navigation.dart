import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:social_book/core/utils/app_colors.dart';
import 'package:social_book/core/utils/constants.dart';

Future<dynamic> nextScreen(context, page) {
  return Navigator.push(
    context,
    PageTransition(
      child: page,
      type: PageTransitionType.fade,
    ),
  );
}

Future<dynamic> nextScreenRemoveUntil(context, page) {
  return Navigator.pushAndRemoveUntil(
    context,
    PageTransition(
      child: page,
      type: PageTransitionType.fade,
    ),
    (route) => false,
  );
}

void customSnackbar(
  BuildContext context,
  String message,
) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      backgroundColor: AppColors.dLightBlueGrey2,
      dismissDirection: DismissDirection.up,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: [
          Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      )));
}

customToast(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
    ),
    clipBehavior: Clip.antiAlias,
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: const Text(
        "Sorry, this feature is currently \nunder development",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
      ),
    ),
  );
}


class CustomAlertDialog extends StatelessWidget {
  final String? title;
  final bool disableTitle;
  final String? description;
  final double? descriptionTxtSize;
  final bool? disableActionBtn;
  final bool? disablePopupBtn;
  final String? popBtnText;
  final Function()? onTap;
  final String? actionBtnTxt;
  const CustomAlertDialog({
    super.key,
    this.title,
    this.disableTitle = true,
    this.description,
    this.descriptionTxtSize,
    this.onTap,
    this.disablePopupBtn = false,
    this.disableActionBtn = false,
    this.popBtnText,
    this.actionBtnTxt,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: disableTitle ? 15 : 0),
          disableTitle
              ? Text(
                  title ?? '',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                )
              : const SizedBox(),
          kHeight(12),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Text(
              description ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: descriptionTxtSize ?? 13,
                  color: Theme.of(context).colorScheme.secondary),
            ),
          ),
          kHeight(10),
          Divider(
            height: 1,
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
          disableActionBtn == false
              ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: InkWell(
                    onTap: onTap,
                    child: Center(
                      child: Text(
                        actionBtnTxt ?? 'Delete',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
          Divider(
            height: disableActionBtn == false ? 1.2 : 0,
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
          disablePopupBtn == false
              ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 45,
                  child: InkWell(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(15),
                    ),
                    highlightColor: Colors.grey[200],
                    onTap: () {
                      Navigator.of(context).pop('refresh');
                    },
                    child: Center(
                      child: Text(
                        popBtnText != null ? popBtnText ?? '' : 'Cancel',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
