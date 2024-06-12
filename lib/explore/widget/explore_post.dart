import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:social_book/presentation/widgets/grid_tile.dart';

class ExplorePost extends StatelessWidget {
  const ExplorePost({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_titleWidget(context), _postGridView(context)],
    );
  }
}

Widget _titleWidget(BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width / 2,
    child: const Stack(
      fit: StackFit.loose,
      children: [
        Align(
            child: Text('Explore Post',
                style: TextStyle(fontSize: 18, height: 1.7)))
      ],
    ),
  );
}

StaggeredGridView _postGridView(BuildContext context) {
  final size = MediaQuery.of(context).size;
  return StaggeredGridView.countBuilder(
    padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    crossAxisCount: 2,
    itemCount: 10,
    itemBuilder: (context, index) {
      return ImageTile(
        height: size.height * 0.26,
        image: 'assets/images/myself.jpg',
      );
    },
    staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
     mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
  );
}
