import 'package:clothes/models/product.dart';
import 'package:clothes/screens/cartScreen.dart';
import 'package:clothes/screens/cartitem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductInfo extends StatefulWidget {
  static String id = 'ProductInfo';
  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int _quantity = 1;
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .75,
                color: Colors.white,
                child: Image(
                  image: AssetImage(product.pLocation),
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * .38,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      spreadRadius: 10, color: Colors.grey, blurRadius: 50)
                ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.pName,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      product.pDescription,
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'EGP ${product.pPrice}',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ClipOval(
                          child: Container(
                            color: Colors.black,
                            child: GestureDetector(
                              onTap: subtract,
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          _quantity.toString(),
                          style: TextStyle(fontSize: 30),
                        ),
                        ClipOval(
                          child: Container(
                            color: Colors.black,
                            child: GestureDetector(
                              onTap: add,
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height * .1,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios)),
                  Text(
                    'Hang',
                    style: TextStyle(fontFamily: 'Pacifico', fontSize: 25),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height * .066,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, CartScreen.id);
                          },
                          child: Icon(Icons.shopping_cart_sharp))),
                ],
              ),
            ),
          ),
          Positioned(
            left: 95,
            bottom: 20,
            child: ButtonTheme(
              minWidth: MediaQuery.of(context).size.width * .5,
              height: MediaQuery.of(context).size.height * .07,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Builder(
                  builder: (context) => RaisedButton(
                    onPressed: () {
                      addtocart(context, product);
                    },
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      'Add to cart'.toUpperCase(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  subtract() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  add() {
    setState(() {
      _quantity++;
    });
  }

  void addtocart(context, product) {
    CartItem cartItem = Provider.of<CartItem>(context, listen: false);
    bool exist = false;
    var productInCart = cartItem.products;
    product.pQuantity = _quantity;
    for (var productInCart in productInCart) {
      if (productInCart.pName == product.pName) {
        exist = true;
      }
    }
    if (exist == true) {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('you already added this item in you cart')));
    } else {
      cartItem.addproduct(product);
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Added to Cart')));
    }
  }
}
