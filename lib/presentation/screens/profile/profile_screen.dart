import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/presentation/screens/profile/widgets/custom_tab_bar_widget.dart';
import 'package:social_book/presentation/screens/profile/widgets/custom_tabview_widget.dart';
import 'package:social_book/presentation/screens/profile/widgets/profile_detail_widget.dart';
import 'package:social_book/presentation/screens/profile/widgets/user_heading_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    // context.read<SavedPostsBloc>().add(FetchAllSavedPostEvent());
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ColorfulSafeArea(
      color: theme.colorScheme.surface,
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        body: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            kHeight(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 60),
                      child: Text(
                        'My Profile',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                ),
                PopupMenuButton(itemBuilder: (BuildContext context) {
                  return [const PopupMenuItem(child: Text(''))];
                })
              ],
            ),
            const ProfileDetailWidget(),
            CustomTabBarWidget(tabController: tabController),
            kHeight(15),
            CustomTabviewWidget(
              tabController: tabController,
            )
          ],
        ),
      ),
    );
  }
}
