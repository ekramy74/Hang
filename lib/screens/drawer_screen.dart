import 'package:clothes/screens/adminScreens/orders_Screen.dart';
import 'package:clothes/screens/choosing_screen.dart';
import 'package:clothes/services/auth.dart';
import 'package:clothes/widgets/animation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerScreen extends StatefulWidget {
  static String id = 'DraweerScreen';

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final _auth = Auth();
  int bottomIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.centerLeft,
              colors: [
            Colors.blue[900],
            Colors.lightBlue.withOpacity(.3),
            Colors.blue[500].withOpacity(.8),
          ])),
      child: Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 10, bottom: 90),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                FadeAnimation(
                  1,
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('images/icons/me.jpg'),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeAnimation(
                      1,
                      Text(
                        'Mahmoud Samy',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),
                      ),
                    ),
                    Row(
                      children: [
                        FadeAnimation(
                          1,
                          Icon(
                            Icons.donut_large,
                            color: Colors.green,
                            size: 15,
                          ),
                        ),
                        FadeAnimation(
                          1,
                          Text('Active Status'),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, OrdersScreen.id);
                      },
                      child: FadeAnimation(
                        1.1,
                        Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, OrdersScreen.id);
                      },
                      child: FadeAnimation(
                        1.1,
                        Text(
                          'view orders',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    FadeAnimation(
                      1.2,
                      Icon(
                        Icons.favorite_outline,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    FadeAnimation(
                      1.2,
                      Text(
                        'favorites',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    FadeAnimation(
                      1.3,
                      Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    FadeAnimation(
                      1.3,
                      Text(
                        'contact us',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
            GestureDetector(
              onTap: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.clear();
                await _auth.signOut();
                Navigator.popAndPushNamed(context, ChoosingScreen.id);
              },
              child: Row(
                children: [
                  FadeAnimation(
                    1.4,
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.doorOpen),
                      color: Colors.white,
                      onPressed: () async {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        pref.clear();
                        await _auth.signOut();
                        Navigator.popAndPushNamed(context, ChoosingScreen.id);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FadeAnimation(
                    1.4,
                    Text(
                      'sign out',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            FadeAnimation(
              1.5,
              Text(
                'Hang',
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Pacifico', fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
