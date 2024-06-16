import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SavedGridViewWidget extends StatelessWidget {
  const SavedGridViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return savedImageCard();
      },
      staggeredTileBuilder: (index) => StaggeredTile.count(
          (index % 7 == 3) ? 2 : 1, (index % 7 == 3) ? 2 : 1),
    );
  }

  Widget savedImageCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        'assets/images/myself.jpg',
        fit: BoxFit.cover,
      ),
    );
  }
}
