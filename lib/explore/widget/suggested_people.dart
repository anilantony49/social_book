import 'package:flutter/material.dart';
import 'package:social_book/core/utils/app_colors.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/presentation/widgets/follow_botton.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SuggestedPeople extends StatelessWidget {
  const SuggestedPeople({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        suggestedHeading(),
        suggestedPeoples(context),
      ],
    );
  }
}

Widget suggestedHeading() {
  return const Padding(
    padding: EdgeInsets.only(left: 20, right: 20),
    child: Row(
      children: [
        Text(
          'Suggested People',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Text(
          'View all',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: AppColors.blueColor),
        )
      ],
    ),
  );
}

Widget suggestedPeoples(BuildContext context) {
  // var theme = Theme.of(context);
  return StaggeredGridView.countBuilder(
    physics: const NeverScrollableScrollPhysics(),
    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
    shrinkWrap: true,
    crossAxisCount: 2,
    staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
    itemCount: 4,
    itemBuilder: (context, index) {
      return Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 218, 217, 215),
          boxShadow: kBoxShadow,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
             backgroundImage: AssetImage('assets/images/myself.jpg'),
                radius: 30,
                // backgroundColor: Color.fromARGB(255, 136, 137, 140)
                ),
            // kHeight(15),
            Text(
              'Anil',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            // kHeight(15),
            Text(
              'Username',
              style: TextStyle(),
            ),
            FollowBotton(),
          ],
        ),
      );
    },
  );
}
