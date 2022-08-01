import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:terra_vision/register_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:terra_vision/login_screen.dart';




class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        duration: 3000,
        splash: 'images/logo.png',
        splashIconSize: 100,
        nextScreen: LoginScreen(),
        splashTransition: SplashTransition.slideTransition,
        backgroundColor: Colors.amber.shade50,
    );
  }
}
