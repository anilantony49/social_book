import 'package:flutter/material.dart';
import 'package:social_book/core/utils/constants.dart';

class MessageUserCard extends StatefulWidget {
  const MessageUserCard({super.key});

  @override
  State<MessageUserCard> createState() => _MessageUserCardState();
}

class _MessageUserCardState extends State<MessageUserCard> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12, top: 12),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  backgroundImage: const AssetImage('assets/images/myself.jpg'),
                  radius: 28,
                  backgroundColor: theme.colorScheme.onSurface,
                ),
                const Positioned(
                    bottom: 4,
                    right: 2,
                    child: CircleAvatar(
                      radius: 6,
                      backgroundColor: Colors.green,
                    ))
              ],
            ),
            kWidth(15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Anil ',
                  style: TextStyle(fontSize: 15),
                ),
                kHeight(5),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 250,
                  child: Text(
                    'message',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                )
              ],
            ),
            const Spacer(),
            Text(
              '12:00',
              style: TextStyle(
                fontSize: 12,
                color: theme.colorScheme.secondary,
              ),
            )
          ],
        ),
      ),
    );
  }
}
