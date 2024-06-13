import 'package:flutter/material.dart';
import 'package:social_book/presentation/screens/user_signin/widgets/sign_in_widget.dart';
import 'package:social_book/presentation/screens/user_signin/widgets/text_field.dart';

class UserSigninScreen extends StatefulWidget {
  const UserSigninScreen({super.key});

  @override
  State<UserSigninScreen> createState() => _UserSigninScreenState();
}

class _UserSigninScreenState extends State<UserSigninScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Container(
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          child:  Padding(
            padding: const EdgeInsets.fromLTRB(0, 40, 0, 30),
            child: Stack(
               alignment: Alignment.center,
               children: [
                const TextFieldWidget(),
                Positioned(
                    bottom: 0,
                    child: signUpNavigate(context),
                  )
               ],
            ),
          ),
        ),
      ),
    );
  }
}
