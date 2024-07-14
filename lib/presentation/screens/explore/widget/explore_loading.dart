import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:social_book/presentation/screens/explore/widget/shimmer_animate.dart';

class ExploreLoading extends StatelessWidget {
  const ExploreLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Tile extends StatelessWidget {
  const Tile({
    super.key,
    required this.height,
  });

  final double height;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ShimmerAnimate(
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: theme.colorScheme.onSurface,
        ),
      ),
    );
  }
}
class ExplorePostLoading extends StatelessWidget {
  const ExplorePostLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 30,
      itemBuilder: (context, index) {
        if (index % 2 == 0 || index == 29) {
          return const Tile(
            height: 220,
          );
        }
        if (index % 3 == 0) {
          return const Tile(height: 150);
        }
        return const Tile(height: 190);
      },
      staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
    );
  }
}