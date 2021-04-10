import 'package:flutter/material.dart';

import 'drawer_screen.dart';
import 'homepage_content.dart';

class HomePageV2 extends StatefulWidget {
  static String id = 'HomePageV2';
  @override
  _HomePageV2State createState() => _HomePageV2State();
}

class _HomePageV2State extends State<HomePageV2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        DrawerScreen(),
        HomePageContent(),
      ],
    ));
  }
}
