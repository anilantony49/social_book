import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax/iconsax.dart';
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
    ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: MediaQuery.of(context).size.height * 0.08,
      color: theme.colorScheme.primaryContainer,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          kIconButton(
            context: context,
            index: 0,
            icon: AppIcons.home,
            theme: theme,
            onDoubleTap: () {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                if (homePageController.hasClients) {
                  homePageController.animateTo(
                    homePageController.position.minScrollExtent,
                    duration: 400.ms,
                    curve: Curves.fastOutSlowIn,
                  );
                }
              });
            },
          ),
          // Container(
          //   height: 20,
          //   width: 1,
          //   color: theme.colorScheme.outlineVariant,
          // ),
          kIconButton(
            context: context,
            index: 1,
            icon: AppIcons.search,
            theme: theme,
            onDoubleTap: () {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                if (explorePageController.hasClients) {
                  explorePageController.animateTo(
                    explorePageController.position.minScrollExtent,
                    duration: 400.ms,
                    curve: Curves.fastOutSlowIn,
                  );
                }
              });
            },
          ),
          // Container(
          //   height: 20,
          //   width: 1,
          //   color: theme.colorScheme.outlineVariant,
          // ),
          kIconButton(
            context: context,
            index: 2,
            
            icon:Iconsax.add_square4,
            theme: theme,
            onDoubleTap: () {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                if (explorePageController.hasClients) {
                  explorePageController.animateTo(
                    explorePageController.position.minScrollExtent,
                    duration: 400.ms,
                    curve: Curves.fastOutSlowIn,
                  );
                }
              });
            },
          ),
          // Container(
          //   height: 20,
          //   width: 1,
          //   color: theme.colorScheme.outlineVariant,
          // ),
          kIconButton(
            context: context,
            index: 3,
            icon: AppIcons.message,
            theme: theme,
            onDoubleTap: () {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                if (messagePageController.hasClients) {
                  messagePageController.animateTo(
                    explorePageController.position.minScrollExtent,
                    duration: 400.ms,
                    curve: Curves.fastOutSlowIn,
                  );
                }
              });
            },
          ),
          // Container(
          //   height: 20,
          //   width: 1,
          //   color: theme.colorScheme.outlineVariant,
          // ),
          kIconButton(
            context: context,
            index: 4,
            icon: AppIcons.user,
            theme: theme,
            onDoubleTap: () {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                if (profilePageController.hasClients) {
                  profilePageController.animateTo(
                    profilePageController.position.minScrollExtent,
                    duration: 400.ms,
                    curve: Curves.fastOutSlowIn,
                  );
                }
              });
            },
          ),
        ],
      ),
    );
  }

  IconButton kIconButton({
    required int index,
    required BuildContext context,
    void Function()? onDoubleTap,
    required IconData icon,
    required ThemeData theme,
  }) {
    return IconButton(
       enableFeedback: false,
        onPressed: () {
          indexChangeNotifier.value = index;
          FocusScope.of(context).unfocus();
        },
        icon: indexChangeNotifier.value == index
            ? GestureDetector(
                onDoubleTap: onDoubleTap,
                child: Icon(
                  icon,
                  color: theme.colorScheme.onPrimary,
                  size: 25,
                ),
              )
            : Icon(
                icon,
                color: theme.colorScheme.secondary,
                size: 25,
              ));
  }
}
