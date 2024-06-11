// import 'package:flutter/material.dart';
// import 'package:social_book/bottom_navigaton_item.dart';
// import 'package:social_book/core/utils/app_colors.dart';
// import 'package:social_book/menu.dart';
// import 'package:social_book/rive_model.dart';

// class BottomNavigationWidget extends StatefulWidget {
//   const BottomNavigationWidget({super.key});

//   @override
//   State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
// }

// class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
//   late Animation<double> animation;
//   List<Menu> bottomNavItems = [
//     Menu(
//       title: "Chat",
//       rive: RiveModel(
//           src: "assets/RiveAssets/icons.riv",
//           artboard: "CHAT",
//           stateMachineName: "CHAT_Interactivity"),
//     ),
//     Menu(
//       title: "Search",
//       rive: RiveModel(
//           src: "assets/RiveAssets/icons.riv",
//           artboard: "SEARCH",
//           stateMachineName: "SEARCH_Interactivity"),
//     ),
//     Menu(
//       title: "Timer",
//       rive: RiveModel(
//           src: "assets/RiveAssets/icons.riv",
//           artboard: "TIMER",
//           stateMachineName: "TIMER_Interactivity"),
//     ),
//     Menu(
//       title: "Notification",
//       rive: RiveModel(
//           src: "assets/RiveAssets/icons.riv",
//           artboard: "BELL",
//           stateMachineName: "BELL_Interactivity"),
//     ),
//     Menu(
//       title: "Profile",
//       rive: RiveModel(
//           src: "assets/RiveAssets/icons.riv",
//           artboard: "USER",
//           stateMachineName: "USER_Interactivity"),
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: Transform.translate(
//         offset: Offset(0, 100 * animation.value),
//         child: SafeArea(
//           child: Container(
//             padding:
//                 const EdgeInsets.only(left: 12, top: 12, right: 12, bottom: 12),
//             margin: const EdgeInsets.symmetric(horizontal: 24),
//             decoration: BoxDecoration(
//               color: AppColors.backgroundColor2.withOpacity(0.8),
//               borderRadius: const BorderRadius.all(Radius.circular(24)),
//               boxShadow: [
//                 BoxShadow(
//                   color: AppColors.backgroundColor2.withOpacity(0.3),
//                   offset: const Offset(0, 20),
//                   blurRadius: 20,
//                 ),
//               ],
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ...List.generate(
//                   bottomNavItems.length,
//                   (index) {
//                     Menu navBar = bottomNavItems[index];
//                     return BtmNavItem(
//                       navBar: navBar,
//                       press: () {
//                         RiveUtils.chnageSMIBoolState(navBar.rive.status!);
//                         updateSelectedBtmNav(navBar);
//                       },
//                       riveOnInit: (artboard) {
//                         navBar.rive.status = RiveUtils.getRiveInput(artboard,
//                             stateMachineName: navBar.rive.stateMachineName);
//                       },
//                       selectedNav: selectedBottonNav,
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
