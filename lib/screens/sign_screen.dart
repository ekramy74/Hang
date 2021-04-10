import 'package:clothes/provider/modal_progress.dart';
//import 'package:clothes/screens/const.dart';
import 'package:clothes/screens/logscreen.dart';
import 'package:clothes/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:clothes/services/auth.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

// ignore: must_be_immutable
class Signupscreen extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  static String id = 'signupscreen';
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
              image: AssetImage('images/icons/background.jpg'),
              fit: BoxFit.cover,
            ),
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
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[100].withOpacity(.5),
                          borderRadius: BorderRadius.circular(30)),
                      child: CustomTextField(
                        OnClick: (value) {},
                        hint: 'Enter your name',
                        icon: Icons.perm_identity,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[100].withOpacity(.5),
                          borderRadius: BorderRadius.circular(30)),
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
                    height: height * .02,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[100].withOpacity(.5),
                          borderRadius: BorderRadius.circular(30)),
                      child: CustomTextField(
                          OnClick: (value) {
                            _password = value;
                          },
                          icon: Icons.lock,
                          hint: 'Enter your Password'),
                    ),
                  ),
                  SizedBox(
                    height: height * .06,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 120),
                    child: Builder(
                      builder: (context) => FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: Colors.white)),
                        onPressed: () async {
                          final modelhud =
                              Provider.of<ModalHud>(context, listen: false);
                          modelhud.changeIsloading(true);
                          if (_globalKey.currentState.validate()) {
                            _globalKey.currentState.save();
                            try {
                              // ignore: unused_local_variable
                              final authResult = await _auth.signup(
                                  _email.trim(), _password.trim());
                              modelhud.changeIsloading(false);
                              Navigator.pushNamed(context, Loginscreen.id);
                            } on PlatformException catch (e) {
                              print(e.toString());
                              modelhud.changeIsloading(false);
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(
                                  e.message,
                                ),
                              ));
                            }
                          }
                          modelhud.changeIsloading(false);
                        },
                        color: Colors.transparent,
                        child: Text(
                          'Sign up',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * .03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Have an account? ',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, Loginscreen.id),
                        child: Text(
                          'Login?',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
