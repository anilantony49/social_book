import 'package:flutter/material.dart';
import 'package:social_book/presentation/screens/profile/widgets/tab_item.dart';

class CustomTabBarWidget extends StatelessWidget {
  const CustomTabBarWidget({super.key, required this.tabController});
    final TabController tabController;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
       height: 35,
        margin: const EdgeInsets.symmetric(horizontal: 50),
        decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(5),
          color: Colors.transparent,
            border: Border.all(
            color: theme.colorScheme.outline,
            width: 1,
          ),
        ),
        child: TabBar(
          tabAlignment: TabAlignment.fill,
          controller: tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          indicator: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(5),
          ),
           labelColor: theme.colorScheme.onPrimaryContainer,
          unselectedLabelColor: theme.colorScheme.primary,
          tabs: const [
            TabItem(title: 'POSTS'),
            TabItem(title: 'SAVED'),
          ],),
    );
  }
}