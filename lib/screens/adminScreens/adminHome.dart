import 'package:clothes/screens/adminScreens/Manage_product.dart';
import 'package:clothes/screens/adminScreens/add_product.dart';
import 'package:clothes/screens/adminScreens/orders_Screen.dart';

import 'package:clothes/screens/const.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({Key key}) : super(key: key);
  static String id = 'AdminHome';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maincolor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
          ),
          FlatButton(
            color: Colors.indigo[100],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onPressed: () {
              Navigator.pushNamed(context, Addproduct.id);
            },
            child: Text('Add product'),
          ),
          FlatButton(
            color: Colors.indigo[100],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onPressed: () {
              Navigator.pushNamed(context, ManageProduct.id);
            },
            child: Text('Manage product'),
          ),
          FlatButton(
            color: Colors.indigo[100],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onPressed: () {
              Navigator.pushNamed(context, OrdersScreen.id);
            },
            child: Text('View Orders'),
          ),
        ],
      ),
    );
  }
}
