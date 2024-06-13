import 'package:flutter/material.dart';
import 'package:social_book/presentation/screens/user_signup_screen/widgets/signup_field_widget.dart';

class UserSignupScreen extends StatefulWidget {
  const UserSignupScreen({super.key});

  @override
  State<UserSignupScreen> createState() => _UserSignupScreenState();
}

class _UserSignupScreenState extends State<UserSignupScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(minHeight: mediaHeight),
            child: const Padding(
              padding: EdgeInsets.fromLTRB(0, 40, 0, 30),
              child: Stack(
                 alignment: Alignment.center,
                 children: [
                   SignupFieldWidget(),
                 ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
