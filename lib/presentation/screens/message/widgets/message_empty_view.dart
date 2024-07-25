import 'package:flutter/material.dart';
import 'package:social_book/core/utils/app_icons.dart';
import 'package:social_book/core/utils/constants.dart';

class MessageEmtpyViewWidget extends StatelessWidget {
  const MessageEmtpyViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Transform.rotate(
                //   angle: -25.0,
                //   child: const Icon(
                //     AppIcons.message_text,
                //     size: 50,
                //     color: Colors.black,
                //   ),
                // ),
                // kHeight(5),
                const Text(
                  "No Messages",
                  style: TextStyle(
                    fontSize: 18,
                    fontVariations: fontWeightW600,
                  ),
                ),
                kHeight(5),
                const Text(
                  'No messages in your inbox',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
