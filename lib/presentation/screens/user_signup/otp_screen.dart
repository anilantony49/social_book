// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:social_book/core/utils/alerts_and_navigation.dart';
// import 'package:social_book/core/utils/app_icons.dart';
// import 'package:social_book/data/model/user_model/user_model.dart';
// import 'package:social_book/main_screen.dart';
// import 'package:social_book/presentation/bloc/user_sign_up/sign_up_bloc.dart';
// import 'package:social_book/presentation/screens/user_signup/widgets/user_name_create_field_widget.dart';
// import 'package:social_book/presentation/widgets/custom_button.dart';

// class OtpScreen extends StatefulWidget {
//   const OtpScreen({super.key});

//   @override
//   _OtpScreenState createState() => _OtpScreenState();
// }

// class _OtpScreenState extends State<OtpScreen> {
//   late List<FocusNode> _focusNodes;
//   late List<TextEditingController> _controllers;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   String? username;
//   String? password;
//   String? email;
//   String? fullName;
//   String? phoneNo;

//   @override
//   void initState() {
//     super.initState();
//     _focusNodes = List<FocusNode>.generate(6, (int index) => FocusNode());
//     _controllers = List<TextEditingController>.generate(
//         6, (int index) => TextEditingController());
//   }

//   @override
//   void dispose() {
//     for (final controller in _controllers) {
//       controller.dispose();
//     }
//     for (final focusNode in _focusNodes) {
//       focusNode.dispose();
//     }
//     super.dispose();
//   }

//   void _nextField(String value, int index) {
//     if (value.length == 1 && index < _focusNodes.length - 1) {
//       _focusNodes[index + 1].requestFocus();
//     } else if (value.length == 1 && index == _focusNodes.length - 1) {
//       _focusNodes[index].unfocus();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Theme.of(context).colorScheme.surface,
//         appBar: AppBar(
//           leading: const Icon(AppIcons.arrow_left_ios),
//         ),
//         body: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: BlocConsumer<SignUpBloc, SignUpState>(
//                 listener: (context, state) {
//               if (state is UserSignUpSuccessState) {
//                 nextScreenRemoveUntil(context, const MainScreen());
//                 context.read<PasswordVisibilityCubit>().reset();
//               }
//               if (state is UsernameExistsErrorState) {
//                 debugPrint('Username already exists');
//                 Navigator.pop(context);
//                 customSnackbar(
//                   context,
//                   'Username already exists',
//                 );
//               }
//               if (state is EmailExistsErrorState) {
//                 debugPrint('Email already exists');
//                 Navigator.pop(context);
//                 customSnackbar(
//                   context,
//                   'Email already exists',
//                 );
//               }
//               if (state is PhonenoExistsErrorState) {
//                 Navigator.pop(context);
//                 customSnackbar(
//                   context,
//                   'Phone number already exists',
//                 );
//               }
//             }, builder: (context, state) {
//               return Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'OTP sent',
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                       textAlign: TextAlign.center,
//                     ),
//                     const Text(
//                       'Enter the 6-digit OTP sent to your email:',
//                       style: TextStyle(fontSize: 16),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 16),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: List.generate(6, (index) {
//                         return SizedBox(
//                           width: 40,
//                           child: TextFormField(
//                             controller: _controllers[index],
//                             focusNode: _focusNodes[index],
//                             keyboardType: TextInputType.number,
//                             textAlign: TextAlign.center,
//                             maxLength: 1,
//                             style: const TextStyle(fontSize: 24),  
//                             decoration: const InputDecoration(
//                               counterText: '',
//                               border: OutlineInputBorder(),
//                             ),
//                             onChanged: (value) {
//                               _nextField(value, index);
//                             },
//                             validator: (val) {
//                               if (val == null || val.isEmpty) {
//                                 return '';
//                               }
//                               return null;
//                             },
//                           ),
//                         );
//                       }),
//                     ),
//                     const SizedBox(height: 20),
//                     SignUpButton(
//                       formKey: _formKey,
//                       otpController: _controllers,
//                       username: username,
//                       password: password,
//                       email: email,
//                       fullName: fullName,
//                       phoneNo: phoneNo,
//                     )
//                   ],
//                 ),
//               );
//             })));
//   }
// }

// class SignUpButton extends StatelessWidget {
//   final GlobalKey<FormState> formKey;
//   final List<TextEditingController> otpController;
//   final String? username;
//   final String? password;
//   final String? email;
//   final String? fullName;
//   final String? phoneNo;

//   const SignUpButton({
//     super.key,
//     required this.formKey,
//     required this.otpController,
//     this.username,
//     this.password,
//     this.email,
//     this.fullName,
//     this.phoneNo,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return CustomButton(
//       buttonText: 'Sign Up',
//       onPressed: () {
//         FocusScope.of(context).unfocus();
//         if (formKey.currentState!.validate()) {
//           String otp =
//               otpController.map((controller) => controller.text).join();
//           print("Entered OTP is: $otp");
//           final user = UserModel(
//               username: username,
//               password: password,
//               email: email,
//               fullName: fullName,
//               phoneNumber: int.parse(phoneNo ?? '0'),
//               otp: otp);
//           context.read<SignUpBloc>().add(UserSignUpEvent(user: user));
//         }
//       },
//     );
//   }
// }
