import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_book/core/theme/app_theme.dart';
import 'package:social_book/presentation/bloc/media_picker/media_picker_bloc.dart';
import 'package:social_book/presentation/bloc/post/post_bloc.dart';
import 'package:social_book/presentation/bloc/post_logics/post_logics_bloc.dart';
import 'package:social_book/presentation/bloc/profile/profile_bloc.dart';
import 'package:social_book/presentation/bloc/profile_logics/profile_logics_bloc.dart';
import 'package:social_book/presentation/bloc/user_sign_in/sign_in_bloc.dart';
import 'package:social_book/presentation/bloc/user_sign_up/sign_up_bloc.dart';
import 'package:social_book/presentation/cubit/drop_down/drop_down_cubit.dart';
import 'package:social_book/presentation/cubit/set_profile_image/cubit/set_profile_image_cubit.dart';
import 'package:social_book/presentation/screens/user_signup/widgets/user_name_create_field_widget.dart';
import 'package:social_book/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignUpBloc()),
        BlocProvider(create: (context) => PasswordVisibilityCubit()),
        BlocProvider(create: (context) => ProfileBloc()),
        BlocProvider(create: (context) => DropdownCubit()),
        BlocProvider(create: (context) => SignInBloc()),
        BlocProvider(create: (context) => ProfileLogicsBloc()),
        BlocProvider(create: (context) => MediaPickerBloc()),
        BlocProvider(create: (context) => SetProfileImageCubit()),
        BlocProvider(create: (context) => PostBloc()),
        BlocProvider(create: (context) => PostLogicsBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SocialBook',
        theme: lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
