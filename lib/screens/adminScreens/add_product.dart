import 'package:clothes/models/product.dart';
import 'package:clothes/screens/adminScreens/Manage_product.dart';
import 'package:clothes/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:clothes/services/store.dart';

// ignore: must_be_immutable
class Addproduct extends StatelessWidget {
  static String id = 'AddProduct';
  // ignore: non_constant_identifier_names
  String _name, _price, _description, _category, image_location;
  final _store = Store();
  final GlobalKey<FormState> _globalkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _globalkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomTextField(
                OnClick: (value) {
                  _name = value;
                },
                icon: null,
                hint: 'Product Name'),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
                OnClick: (value) {
                  _price = value;
                },
                icon: null,
                hint: 'Product Price'),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
                OnClick: (value) {
                  _description = value;
                },
                icon: null,
                hint: 'Product Description'),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
                OnClick: (value) {
                  _category = value;
                },
                icon: null,
                hint: 'Product Category'),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
                OnClick: (value) {
                  image_location = value;
                },
                icon: null,
                hint: 'Product Location'),
            SizedBox(
              height: 20,
            ),
            FlatButton(
              color: Colors.indigo[100],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPressed: () {
                if (_globalkey.currentState.validate()) {
                  _globalkey.currentState.save();
                  _store.Addproduct(Product(
                    pName: _name,
                    pPrice: _price,
                    pDescription: _description,
                    pCategory: _category,
                    pLocation: image_location,
                  ));
                  Navigator.pushNamed(context, ManageProduct.id);
                }
              },
              child: Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
