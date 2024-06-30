import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/core/utils/app_icons.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/main_screen.dart';
import 'package:social_book/presentation/bloc/user_sign_in/sign_in_bloc.dart';
import 'package:social_book/presentation/screens/forgot_password/forgot_password_screen.dart';
import 'package:social_book/presentation/screens/home/home_screen.dart';
import 'package:social_book/presentation/screens/user_signup/widgets/user_name_create_field_widget.dart';
import 'package:social_book/presentation/widgets/custom_button.dart';
import 'package:social_book/presentation/widgets/custom_text_form_field.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({super.key});

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listener: signInListener,
      builder: (context, state) {
        return FadeInDown(
          delay: const Duration(milliseconds: 400),
          // duration: const Duration(milliseconds: 500),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 40, 40, 30),
            child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Welcome back!',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          kHeight(10),
                          const Text(
                            "Enter your login details to continue.",
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    kHeight(25),
                    CustomTextFormField(
                      controller: usernameController,
                      hintText: 'Username',
                      validator: (value) {
                        if (value!.length < 4) {
                          return 'Username should not be empty';
                        }
                        return null;
                      },
                    ),
                    kHeight(20),

                    // Password field

                    BlocBuilder<PasswordVisibilityCubit, bool>(
                      builder: (context, state) {
                        return CustomTextFormField(
                          controller: passwordController,
                          hintText: 'Password',
                          suffix: GestureDetector(
                            onTap: () {
                              context
                                  .read<PasswordVisibilityCubit>()
                                  .toggleVisibility();
                            },
                            child: Icon(
                                state ? AppIcons.eyeslash : AppIcons.eye,
                                size: 20,
                                color: Colors.grey),
                          ),
                          obscureText: state,
                          validator: (value) {
                            if (value!.length < 4) {
                              return 'Password should not be empty';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                    kHeight(25),

                    // Sign in button
                    CustomButton(
                      buttonText: 'Sign In',
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if (formKey.currentState!.validate()) {
                          context.read<SignInBloc>().add(
                                UserSignInEvent(
                                  username: usernameController.text,
                                  password: passwordController.text,
                                ),
                              );
                        }
                      },
                    ),
                    kHeight(10),
                    InkWell(
                      onTap: () {
                        nextScreen(context, const ForgotPasswordScreen());
                      },
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Forget Password?',
                        ),
                      ),
                    ),
                    kHeight(15),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 45,
                          height: 45,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/Google__G__logo.svg.webp',
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              _signInWithGoogle();
                            },
                            child: const Text(
                              'Sign in with Google',
                              style: TextStyle(color: Colors.grey),
                            ))
                      ],
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }

  void signInListener(BuildContext context, SignInState state) {
    if (state is InvalidUsernameErrorState) {
      customSnackbar(
        context,
        "Username doesn't exist",
      );
    }
    if (state is InvalidPasswordErrorState) {
      customSnackbar(
        context,
        "Incorrect password",
      );
    }

    if (state is UserSignInSuccessState) {
      nextScreenRemoveUntil(context, const MainScreen());
      context.read<PasswordVisibilityCubit>().reset();
    }

    if (state is UserSignInErrorState) {
      customSnackbar(
        context,
        'Please try again after some times',
      );
    }
  }

  _signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);
        await _firebaseAuth.signInWithCredential(credential);
        nextScreen(context, HomeScreen());
      }
    } catch (e) {
      print('error occured');
    }
  }
}
