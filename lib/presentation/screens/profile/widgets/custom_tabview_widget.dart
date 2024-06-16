import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:flutter/material.dart';
import 'package:social_book/presentation/screens/profile/widgets/saved_grid_view.dart';

class CustomTabviewWidget extends StatelessWidget {
  const CustomTabviewWidget({super.key, required this.tabController});
  final TabController tabController;
  @override
  Widget build(BuildContext context) {
    return AutoScaleTabBarView(
      controller: tabController,
      children: const [SavedGridViewWidget(),SavedGridViewWidget()],
    );
  }
}
