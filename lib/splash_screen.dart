import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/data/services/shared_preference/shared_preference.dart';
import 'package:social_book/main_screen.dart';
import 'package:social_book/presentation/screens/home/home_screen.dart';
import 'package:social_book/presentation/screens/user_signin/user_signin_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkUserStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 255, 251, 251),
      body: Stack(
        children: [
          // First Circle
          Positioned(
            width: MediaQuery.of(context).size.width * 1.7,
            left: -30,
            top: 130,
            // bottom: 100,
            child: const CircleAvatar(
              radius: 60,
              backgroundColor: Color(0xFFFEBEBE),
            )
                .animate()
                .moveY(
                  begin: 0,
                  end: 20,
                  duration: 2000.ms,
                  curve: Curves.easeInOut,
                )
                .then()
                .moveY(
                  begin: 20,
                  end: 0,
                  duration: 2000.ms,
                  curve: Curves.easeInOut,
                ),
          ),
          // Second Circle
          Positioned(
            width: MediaQuery.of(context).size.width * 1.7,
            left: -210,
            top: 200,
            child: const CircleAvatar(
                    radius: 35, backgroundColor: Color(0xFF4B6EC8))
                .animate()
                .moveY(
                  begin: 0,
                  end: 20,
                  duration: 2000.ms,
                  curve: Curves.easeInOut,
                )
                .then()
                .moveY(
                  begin: 20,
                  end: 0,
                  duration: 2000.ms,
                  curve: Curves.easeInOut,
                ),
          ),
          Positioned(
            width: MediaQuery.of(context).size.width * 1.7,
            right: -15,
            bottom: 260,
            child: const CircleAvatar(
                    radius: 40, backgroundColor: Color(0xFF63DEF7))
                .animate()
                .moveY(
                  begin: 0,
                  end: 20,
                  duration: 2000.ms,
                  curve: Curves.easeInOut,
                )
                .then()
                .moveY(
                  begin: 20,
                  end: 0,
                  duration: 2000.ms,
                  curve: Curves.easeInOut,
                ),
          ),
          Positioned(
            width: MediaQuery.of(context).size.width * 1.7,
            left: -5,
            bottom: 270,
            child: const CircleAvatar(
                    radius: 25, backgroundColor: Color(0xFF597D85))
                .animate()
                .moveY(
                  begin: 0,
                  end: 20,
                  duration: 2000.ms,
                  curve: Curves.easeInOut,
                )
                .then()
                .moveY(
                  begin: 20,
                  end: 0,
                  duration: 2000.ms,
                  curve: Curves.easeInOut,
                ),
          ),

          Positioned(
            width: MediaQuery.of(context).size.width * 1.7,
            left: -50,
            bottom: 70,
            child: const CircleAvatar(
                    radius: 35, backgroundColor: Color(0xFFDB70E4))
                .animate()
                .moveY(
                  begin: 0,
                  end: 20,
                  duration: 2000.ms,
                  curve: Curves.easeInOut,
                )
                .then()
                .moveY(
                  begin: 20,
                  end: 0,
                  duration: 2000.ms,
                  curve: Curves.easeInOut,
                ),
          ),
          const Center(
            child: LetterAnimation(),
          ),
          Positioned(
              top: 368,
              right: 214,
              child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 3500),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          Colors.white.withOpacity(value),
                          BlendMode.modulate,
                        ),
                        child: Image.asset(
                          'assets/images/smile.png',
                          width: 14,
                          height: 14,
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }

  Future<void> checkUserStatus() async {
    final userOnInitial = await UserAuthStatus.isUserOnInitial();
    final userSignIn = await UserAuthStatus.getUserStatus();
    if (userOnInitial == false) {
      await Future.delayed(const Duration(seconds: 7));
      nextScreenRemoveUntil(context, const UserSigninScreen());
    } else {
      if (userSignIn == false) {
        await Future.delayed(const Duration(seconds: 7));
        nextScreenRemoveUntil(context, const UserSigninScreen());
      } else {
        await Future.delayed(const Duration(seconds: 7));
        nextScreenRemoveUntil(context, const MainScreen());
      }
    }
  }
}

class LetterAnimation extends StatelessWidget {
  const LetterAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    const String text = 'SocıalBook';
    const duration = Duration(milliseconds: 250);
    final totalDuration = duration * text.length;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(text.length, (index) {
        // int index = text.indexOf(char);
        return Animate(
          child: Text(
            text[index],
            style: GoogleFonts.sniglet(fontSize: 35),
          ),
        )
            .fadeIn(delay: duration * index, duration: duration)
            .shimmer(delay: duration, duration: duration);
      }).toList(),
    ).animate().shimmer(delay: totalDuration, duration: 2000.ms);
  }
}
