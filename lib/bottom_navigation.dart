import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:social_book/core/utils/app_colors.dart';
import 'package:social_book/core/utils/app_icons.dart';

ValueNotifier<int> indexChangeNotifier = ValueNotifier(0);
final homePageController = ScrollController();
final explorePageController = ScrollController();
final messagePageController = ScrollController();
final profilePageController = ScrollController();

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: MediaQuery.of(context).size.height * 0.08,
      color: const Color.fromARGB(255, 219, 215, 215),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          kIconButton(
            context: context,
            index: 0,
            icon: AppIcons.home,
          ),
          kIconButton(
            context: context,
            index: 1,
            icon: AppIcons.search,
          ),
          kIconButton(
            context: context,
            index: 2,
            icon: Iconsax.add_square4,
          ),
          kIconButton(
            context: context,
            index: 3,
            icon: AppIcons.message,
          ),
          kIconButton(
            context: context,
            index: 4,
            icon: AppIcons.user,
          ),
        ],
      ),
    );
  }

  Widget kIconButton({
    required int index,
    required BuildContext context,
    required IconData icon,
  }) {
    return ValueListenableBuilder(
      valueListenable: indexChangeNotifier,
      builder: (context, currentIndex, child) {
        return IconButton(
            enableFeedback: false,
            onPressed: () {
              indexChangeNotifier.value = index;
              FocusScope.of(context).unfocus();
            },
            icon: indexChangeNotifier.value == index
                ? GestureDetector(
                    child: Icon(
                      icon,
                      color: AppColors.customBtnColor,
                      size: 25,
                    ),
                  )
                : Icon(
                    icon,
                    color: Colors.black,
                    size: 25,
                  ));
      },
    );
  }
}
