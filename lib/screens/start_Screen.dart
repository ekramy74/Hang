import 'package:clothes/screens/choosing_screen.dart';
import 'package:clothes/screens/const.dart';
import 'package:clothes/screens/home_page.dart';
//import 'package:clothes/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
  static String id = 'StartScreen';
}

class _StartScreenState extends State<StartScreen> {
  bool isUserLoggedIn = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text('loading...'),
                ),
              ),
            );
          } else {
            isUserLoggedIn = snapshot.data.getBool(kkeepMeLoggedIn) ?? false;
            return Scaffold(
                body: AnimatedSplashScreen(
                    splash: 'images/icons/mainIcon.png',
                    splashIconSize: 200,
                    nextScreen: isUserLoggedIn ? HomePage() : ChoosingScreen(),
                    splashTransition: SplashTransition.fadeTransition,
                    pageTransitionType: PageTransitionType.topToBottom,
                    animationDuration: Duration(seconds: 1),
                    duration: 500,
                    backgroundColor: Colors.white));
          }
        });
  }
}
