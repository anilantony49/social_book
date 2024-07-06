import 'package:flutter/material.dart';
import 'package:social_book/presentation/screens/forgot_password/widget/reset_field_widget.dart';
import 'package:social_book/presentation/screens/user_signup/widgets/signin_navigate_widget.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, required this.emailController});
  final TextEditingController emailController;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(minHeight: mediaHeight),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 40, 0, 30),
            child: Stack(
              alignment: Alignment.center,
              children: [
                ResetFieldWidget(email: widget.emailController.text),
                Positioned(
                  bottom: 0,
                  child: signInNavigate(context),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
