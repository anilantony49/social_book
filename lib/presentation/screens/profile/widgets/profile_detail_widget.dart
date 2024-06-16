import 'package:flutter/material.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/presentation/screens/profile/widgets/user_heading_widget.dart';
import 'package:social_book/presentation/widgets/custom_button.dart';
import 'package:social_book/presentation/widgets/custom_button_profile.dart';

class ProfileDetailWidget extends StatelessWidget {
  const ProfileDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 10, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            backgroundImage:AssetImage('assets/images/myself.jpg'),
            backgroundColor: Colors.grey,
            radius: 35,
          ),
          kHeight(10),
          const Text(
            'Anil Antnoy',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          // UserHeadingWidget(),
          kHeight(10),
          const Text(
            'Description',
          ),
          kHeight(10),
          CustomButtonProfile(
            buttonText: 'Edit profile',
            onPressed: () {
              FocusScope.of(context).unfocus();
            },
          ),
          kHeight(10),
          const Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text('87', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Posts')
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                child: VerticalDivider(
                  color: Colors.black, // Set the color of the divider
                  thickness: 1, // Set the thickness of the divider
                  width: 20, // Set the width space for the divider
                  indent: 10, // Set the top padding for the divider
                  endIndent: 10, // Set the bottom padding for the divider
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text('870', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Following')
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                child: VerticalDivider(
                  color: Colors.black, // Set the color of the divider
                  thickness: 1, // Set the thickness of the divider
                  width: 20, // Set the width space for the divider
                  indent: 10, // Set the top padding for the divider
                  endIndent: 10, // Set the bottom padding for the divider
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '15K',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('Followers')
                  ],
                ),
              ),
            ],
          ),
          //  kHeight(50),
           
        ],
      ),
    );
  }
}
