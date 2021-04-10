//import 'package:clothes/screens/const.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  // ignore: non_constant_identifier_names
  final Function OnClick;
  CustomTextField(
      // ignore: non_constant_identifier_names
      {@required this.OnClick,
      @required this.icon,
      @required this.hint});
  // ignore: missing_return
  String _errormsg(String str) {
    switch (hint) {
      case 'Enter your name':
        return 'Name is empty!!!';

        break;
      case 'Enter your Email':
        return 'Email is empty!!!';
      case 'Enter your Password':
        return 'Password is empty!!!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: Colors.transparent,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: TextFormField(
        // ignore: missing_return
        validator: (value) {
          if (value.isEmpty) {
            return _errormsg(hint);
          }
        },
        onSaved: OnClick,
        obscureText: hint == 'Enter your Password' ? true : false,
        cursorColor: Colors.black,
        decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(
              icon,
              color: Colors.white,
            ),
            filled: true,
            fillColor: Colors.transparent,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(20),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(20),
            )),
      ),
    );
  }
}
