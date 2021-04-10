import 'package:clothes/provider/admin_mode.dart';
import 'package:clothes/provider/modal_progress.dart';
import 'package:clothes/screens/adminScreens/adminHome.dart';
import 'package:clothes/screens/const.dart';
import 'package:clothes/screens/welcome_screen.dart';
import 'package:clothes/screens/sign_screen.dart';
import 'package:flutter/material.dart';
import 'package:clothes/widgets/textfield.dart';
import 'package:clothes/services/auth.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Loginscreen extends StatefulWidget {
  static String id = 'Loginscreen';

  @override
  _LoginscreenState createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  bool isAdmin = false;

  final adminPass = 'admin1234';

  bool keepMeLoggedIn = false;

  String _email, _password;

  final _auth = Auth();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: new DecorationImage(
              image: AssetImage('images/icons/background3.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
              Colors.black.withOpacity(.7),
              Colors.black.withOpacity(.4)
            ])),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: ModalProgressHUD(
            inAsyncCall: Provider.of<ModalHud>(context).isLoading,
            child: Form(
              key: _globalKey,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Container(
                      height: MediaQuery.of(context).size.height * .2,
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Image(image: AssetImage('images/icons/mainIcon.png')),
                          Positioned(
                            bottom: 0,
                            child: Text(
                              'Hang',
                              style: TextStyle(
                                  fontFamily: 'Pacifico', fontSize: 40.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * .1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.6),
                          borderRadius: BorderRadius.circular(40)),
                      child: CustomTextField(
                        OnClick: (value) {
                          _email = value;
                        },
                        hint: 'Enter your Email',
                        icon: Icons.email,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * .03,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[100].withOpacity(.6),
                          borderRadius: BorderRadius.circular(40)),
                      child: CustomTextField(
                          OnClick: (value) {
                            _password = value;
                          },
                          icon: Icons.lock,
                          hint: 'Enter your Password'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Row(
                      children: [
                        Theme(
                          data: ThemeData(
                            unselectedWidgetColor: Colors.white,
                          ),
                          child: Checkbox(
                            activeColor: Colors.transparent,
                            checkColor: Colors.white,
                            value: keepMeLoggedIn,
                            onChanged: (value) {
                              setState(() {
                                keepMeLoggedIn = value;
                              });
                            },
                          ),
                        ),
                        Text(
                          'Remember Me?',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 120),
                    child: Builder(
                      builder: (context) => FlatButton(
                        splashColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.white),
                        ),
                        onPressed: () {
                          if (keepMeLoggedIn == true) {
                            keepUserLoggedin();
                          }
                          _validate(context);
                        },
                        color: Colors.transparent,
                        child: Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * .05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Don\'t have an account? ',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16.0,
                        ),
                      ),
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, Signupscreen.id),
                        child: Text(
                          'Sign up?',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Provider.of<AdminMode>(context, listen: false)
                                  .changeIsAdmin(true);
                            },
                            child: Text('i\'m an admin',
                                style: TextStyle(
                                    color:
                                        Provider.of<AdminMode>(context).isAdmin
                                            ? Colors.transparent
                                            : Colors.white),
                                textAlign: TextAlign.center),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Provider.of<AdminMode>(context, listen: false)
                                  .changeIsAdmin(false);
                            },
                            child: Text(
                              'i\'m a user',
                              style: TextStyle(
                                  color: Provider.of<AdminMode>(context).isAdmin
                                      ? Colors.white
                                      : Colors.transparent),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _validate(BuildContext context) async {
    final modelhud = Provider.of<ModalHud>(context, listen: false);
    modelhud.changeIsloading(true);
    if (_globalKey.currentState.validate()) {
      _globalKey.currentState.save();
      if (Provider.of<AdminMode>(context, listen: false).isAdmin) {
        if (_password.trim() == adminPass) {
          try {
            // ignore: unused_local_variable
            _auth.signin(_email.trim(), _password.trim());
            modelhud.changeIsloading(false);
            Navigator.pushNamed(context, AdminHome.id); //do smth
          } on PlatformException catch (e) {
            modelhud.changeIsloading(false);
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(e.message),
              ),
            );
          }
        } else {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Something went Wrong kindlly check your e-mail or password'),
            ),
          );
        }
      } else {
        try {
          // ignore: unused_local_variable
          await _auth.signin(_email.trim(), _password.trim());
          modelhud.changeIsloading(false);
          Navigator.pushNamed(context, WelcomeScreen.id); //do smth
        } on PlatformException catch (e) {
          modelhud.changeIsloading(false);
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(e.message),
            ),
          );
        }
      }
    }
    modelhud.changeIsloading(false);
  }

  void keepUserLoggedin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(kkeepMeLoggedIn, keepMeLoggedIn);
  }
}
