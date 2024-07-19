// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:social_book/presentation/bloc/search_follower/search_follower_bloc.dart';

// class FollowersView extends StatelessWidget {
//   const FollowersView({
//     super.key,
//     required this.followers,
//     required this.isCurrentUser,
//   });

//   final List followers;
//   final bool isCurrentUser;

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SearchBloc, SearchState>(
//       builder: (context, state) {
//         if (state is SearchFollowerLoadedState) {
//           return state.followers.isEmpty
//               ? const Center(
//                   child: Text('No users found'),
//                 )
//               : FollowSearchResult(
//                   state: state,
//                 );
//         }
//         return FollowSearchIdle(
//           followers: followers,
//           isCurrentUser: isCurrentUser,
//         );
//       },
//     );
//   }
// }
