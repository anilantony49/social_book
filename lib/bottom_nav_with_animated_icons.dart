import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:social_book/bottom_navigation_item_model.dart';
import 'package:social_book/core/utils/app_colors.dart';
import 'package:social_book/home/home_screen.dart';

class BottomNavWithAnimatedIcons extends StatefulWidget {
  const BottomNavWithAnimatedIcons({super.key});

  @override
  State<BottomNavWithAnimatedIcons> createState() =>
      _BottomNavWithAnimatedIconsState();
}

class _BottomNavWithAnimatedIconsState
    extends State<BottomNavWithAnimatedIcons> {
  List<SMIBool> riveIconInputs = [];

  List<StateMachineController?> controllers = [];

  int selectedNavIndex = 0;

  var pages = const [
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
  ];

  void animateTheIcon(int index) {
    riveIconInputs[index].change(true);
    Future.delayed(const Duration(seconds: 1), () {
      riveIconInputs[index].change(false);
    });
  }

  void riveOnInit(Artboard artboard, {required String stateMachineName}) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, stateMachineName);
    artboard.addController(controller!);
    controllers.add(controller);
    riveIconInputs.add(controller.findInput<bool>('active') as SMIBool);
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (pages[selectedNavIndex]),
      bottomNavigationBar: SafeArea(
        child: Container(
          // height: 58,s
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          decoration: BoxDecoration(
              color: AppColors.bottomNavBgColor.withOpacity(0.8),
              borderRadius: const BorderRadius.all(Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                    color: AppColors.bottomNavBgColor.withOpacity(0.3),
                    offset: const Offset(0, 20),
                    blurRadius: 20)
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(bottomNavItems.length, (index) {
              final riveIcon = bottomNavItems[index].rive;
              return GestureDetector(
                onTap: () {
                  animateTheIcon(index);
                  setState(() {
                    selectedNavIndex = index;
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedBar(isActive: selectedNavIndex == index),
                    SizedBox(
                      height: 36,
                      width: 36,
                      child: Opacity(
                        opacity: selectedNavIndex == index ? 1 : 0.5,
                        child: RiveAnimation.asset(
                          riveIcon.src,
                          artboard: riveIcon.artboard,
                          onInit: (artboard) {
                            riveOnInit(artboard,
                                stateMachineName: riveIcon.stateMachineName);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class AnimatedBar extends StatelessWidget {
  const AnimatedBar({
    super.key,
    required this.isActive,
  });
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 2),
      height: 4,
      width: isActive ? 20 : 0,
      decoration: const BoxDecoration(
          color: Color(0xFF81B4FF),
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }
}
