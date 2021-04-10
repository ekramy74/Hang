import 'package:clothes/screens/home_page.dart';
import 'package:clothes/screens/logscreen.dart';
import 'package:clothes/screens/sign_screen.dart';
import 'package:clothes/screens/welcome_screen.dart';
import 'package:clothes/widgets/animation.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ChoosingScreen extends StatefulWidget {
  static String id = 'ChoosingScreen';

  @override
  _ChoosingScreenState createState() => _ChoosingScreenState();
}

class _ChoosingScreenState extends State<ChoosingScreen>
    with TickerProviderStateMixin {
  AnimationController _scaleController;
  Animation<double> _scaleAnimation;
  bool hide = false;

  void initState() {
    super.initState();
    _scaleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 30.0).animate(_scaleController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              Navigator.push(
                  context,
                  PageTransition(
                      child: WelcomeScreen(),
                      type: PageTransitionType.fade,
                      duration: Duration(milliseconds: 500)));
            }
          });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: AssetImage('images/icons/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
            Colors.black.withOpacity(.9),
            Colors.black.withOpacity(.4)
          ])),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FadeAnimation(
                  1,
                  Text(
                    'Brand New Prespective',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                FadeAnimation(
                  1.2,
                  Text(
                    'Let\'s start with our collection.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      hide = true;
                    });
                    _scaleController.forward();
                  },
                  child: AnimatedBuilder(
                    animation: _scaleController,
                    builder: (context, child) => Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Center(
                        child: FadeAnimation(
                          1.2,
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(color: Colors.white),
                              color: Colors.white,
                            ),
                            height: MediaQuery.of(context).size.height * .06,
                            width: MediaQuery.of(context).size.width * .7,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 72),
                              child: hide == false
                                  ? Row(
                                      children: [
                                        Text(
                                          'Get Start',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Icon(Icons.arrow_forward)
                                      ],
                                    )
                                  : Container(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: FadeAnimation(
                    1.3,
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: Colors.white),
                      ),
                      height: MediaQuery.of(context).size.height * .06,
                      width: MediaQuery.of(context).size.width * .7,
                      child: Center(
                        child: Text(
                          'Create an Account',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
