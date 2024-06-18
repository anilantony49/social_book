import 'package:flutter/material.dart';
import 'package:social_book/presentation/screens/user_signup/widgets/signin_navigate_widget.dart';
import 'package:social_book/presentation/screens/user_signup/widgets/user_name_create_field_widget.dart';

class UserNameCreateScreen extends StatefulWidget {
  const UserNameCreateScreen(
      {super.key,
      required this.email,
      required this.phoneNo,
      required this.fullName});
  final String email;
  final String phoneNo;
  final String fullName;
  @override
  State<UserNameCreateScreen> createState() => _UserNameCreateScreenState();
}

class _UserNameCreateScreenState extends State<UserNameCreateScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        // extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(minHeight: mediaHeight),
            child:  Padding(
              padding: const EdgeInsets.fromLTRB(0, 40, 0, 30),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  UserNameCreateFieldWidget(
                    email:widget.email,
                    phoneNo: widget.phoneNo,
                    fullName: widget.fullName,
                  ), Positioned(
                    bottom: 0,
                    child: signInNavigate(context)
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
