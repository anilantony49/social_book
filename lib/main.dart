import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_book/core/theme/app_theme.dart';
import 'package:social_book/main_screen.dart';
import 'package:social_book/presentation/bloc/comment/comment_bloc.dart';
import 'package:social_book/presentation/bloc/follow_unfollow_user/follow_unfollow_user_bloc.dart';
import 'package:social_book/presentation/bloc/forget_password/forget_password_bloc.dart';
import 'package:social_book/presentation/bloc/like_unlike/like_unlike_bloc.dart';
import 'package:social_book/presentation/bloc/media_picker/media_picker_bloc.dart';
import 'package:social_book/presentation/bloc/post/post_bloc.dart';
import 'package:social_book/presentation/bloc/post_edit/post_edit_bloc.dart';
import 'package:social_book/presentation/bloc/post_logics/post_logics_bloc.dart';
import 'package:social_book/presentation/bloc/profile/profile_bloc.dart';
import 'package:social_book/presentation/bloc/profile_logics/profile_logics_bloc.dart';
import 'package:social_book/presentation/bloc/saved_posts/saved_posts_bloc.dart';
import 'package:social_book/presentation/bloc/search_follower/search_follower_bloc.dart';
import 'package:social_book/presentation/bloc/search_user/search_user_bloc.dart';
import 'package:social_book/presentation/bloc/story/story_bloc.dart';
import 'package:social_book/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:social_book/presentation/bloc/user_by_id/user_by_id_bloc.dart';
import 'package:social_book/presentation/bloc/user_sign_in/sign_in_bloc.dart';
import 'package:social_book/presentation/bloc/user_sign_up/sign_up_bloc.dart';
import 'package:social_book/presentation/cubit/drop_down/drop_down_cubit.dart';
import 'package:social_book/presentation/cubit/post_image_index.dart/post_image_index.dart';
import 'package:social_book/presentation/cubit/search/search_cubit.dart';
import 'package:social_book/presentation/cubit/set_profile_image/cubit/set_profile_image_cubit.dart';
import 'package:social_book/presentation/cubit/story_index/story_index_cubit.dart';
import 'package:social_book/presentation/screens/home/home_screen.dart';
import 'package:social_book/presentation/screens/user_signup/widgets/user_name_create_field_widget.dart';
import 'package:social_book/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyBmEDmYU6_-ATThpcn5BH5V-_ci1cWTb9c',
              appId: '1:857352775882:android:80384836889ee711726c33',
              messagingSenderId: '857352775882',
              projectId: 'authentication-c5353'))
      : await Firebase.initializeApp();
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
        BlocProvider(create: (context) => ForgetPasswordBloc()),
        BlocProvider(create: (context) => ProfileLogicsBloc()),
        BlocProvider(create: (context) => MediaPickerBloc()),
        BlocProvider(create: (context) => SetProfileImageCubit()),
        BlocProvider(create: (context) => PostImageIndexCubit()),
        BlocProvider(create: (context) => PostBloc()),
        BlocProvider(create: (context) => PostEditBloc()),
        BlocProvider(create: (context) => PostLogicsBloc()),
        BlocProvider(create: (context) => LikeUnlikeBloc()),
        BlocProvider(create: (context) => CommentBloc()),
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context) => UserByIdBloc()),
        BlocProvider(create: (context) => FollowUnfollowUserBloc()),
        BlocProvider(create: (context) => SearchUserBloc()),
        BlocProvider(create: (context) => SavedPostsBloc()),
        BlocProvider(create: (context) => OnSearchCubit()),
        BlocProvider(create: (context) => SearchBloc()),
        BlocProvider(create: (context) => StoryBloc()),
        BlocProvider(create: (context) => StoryIndexCubit()),
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
