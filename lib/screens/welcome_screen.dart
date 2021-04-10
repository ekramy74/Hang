import 'package:clothes/screens/home_page.dart';
import 'package:clothes/screens/home_pageV2.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
  static String id = 'WelcomeScreen';
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedSplashScreen(
            splash: 'images/icons/mainIcon.png',
            splashIconSize: 200,
            nextScreen: HomePageV2(),
            splashTransition: SplashTransition.sizeTransition,
            pageTransitionType: PageTransitionType.topToBottom,
            animationDuration: Duration(seconds: 1),
            duration: 500,
            backgroundColor: Colors.white));
  }
}
