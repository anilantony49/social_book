import 'package:flutter/material.dart';
import 'package:social_book/core/utils/constants.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: List.generate(
            10,
            (index) => const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: PostList(),
                )),
      ),
    );
  }
}

class PostList extends StatelessWidget {
  const PostList({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(
        child: Container(
          width: 340,
          height: 480,
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 215, 214, 214),
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(25, 10, 15, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 50,
                  height: 50,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/myself.jpg'),
                    backgroundColor: Color(0xFFF2F2F2),
                    // radius: 10,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Anil Antony',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    Text(
                      '1hr ago',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                    )
                  ],
                ),
                const Spacer(),
                PopupMenuButton(itemBuilder: (
                  BuildContext context,
                ) {
                  return [const PopupMenuItem(child: Text(''))];
                })
              ],
            ),
            kHeight(10),
            const Text('Description'),
            kHeight(10),
            Container(
              height: 250,
              width: 310,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // color: Colors.blue,
                  image: const DecorationImage(
                    image: AssetImage('assets/images/myself.jpg'),
                    fit: BoxFit.cover,
                  )),
            ),
            kHeight(10),
            const Row(
              children: [
                Column(
                  children: [Icon(Icons.favorite_outline), Text('100 Likes')],
                ),
                SizedBox(
                  width: 30,
                ),
                Column(
                  children: [
                    Icon(Icons.comment_outlined),
                    Text('100 Comments')
                  ],
                ),
                SizedBox(
                  width: 90,
                ),
                Column(
                  children: [
                    Icon(Icons.bookmark_border),
                    SizedBox(
                      height: 20,
                    )
                  ],
                )
              ],
            ),
            kHeight(10),
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Liked by ',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                  TextSpan(
                    text: 'Anil',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: ' and ',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                  TextSpan(
                    text: '100',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: ' Others',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            kHeight(10),
            const Text('View all 57 commenets')
          ],
        ),
      ),
    ]);
  }
}
