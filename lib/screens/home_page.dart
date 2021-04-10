import 'package:clothes/models/product.dart';
import 'package:clothes/screens/cartScreen.dart';
import 'package:clothes/screens/const.dart';
import 'package:clothes/screens/logscreen.dart';
import 'package:clothes/screens/product_info.dart';
import 'package:clothes/services/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:clothes/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  static String id = 'HomePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tapbarIndex = 0;
  final _store = Store();
  // ignore: unused_field
  FirebaseUser _loggedUser;
  // ignore: unused_field
  final _auth = Auth();
  int bottomIndex = 0;
  List<Product> _products;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DefaultTabController(
          length: 4,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: bottomIndex,
                onTap: (value) async {
                  setState(() {
                    bottomIndex = value;
                  });
                  if (value == 2) {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    pref.clear();
                    await _auth.signOut();
                    Navigator.popAndPushNamed(context, Loginscreen.id);
                  }
                },
                fixedColor: maincolor,
                items: [
                  BottomNavigationBarItem(
                      // ignore: deprecated_member_use
                      title: Text(
                        'Products'.toUpperCase(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      icon: Icon(Icons.home)),
                  BottomNavigationBarItem(
                      // ignore: deprecated_member_use
                      title: Text(
                        'Search'.toUpperCase(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      icon: Icon(Icons.search)),
                  BottomNavigationBarItem(
                      // ignore: deprecated_member_use
                      title: Text('sign out'.toUpperCase()),
                      icon: Icon(Icons.power_settings_new)),
                ]),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              bottom: TabBar(
                  indicatorColor: maincolor,
                  onTap: (value) {
                    setState(() {
                      tapbarIndex = value;
                    });
                  },
                  tabs: <Widget>[
                    Text(
                      'T-shirts',
                      style: TextStyle(
                          color: tapbarIndex == 0 ? Colors.black : unactaive,
                          fontSize: tapbarIndex == 0 ? 14 : null),
                    ),
                    Text('Jeans',
                        style: TextStyle(
                            color: tapbarIndex == 1 ? Colors.black : unactaive,
                            fontSize: tapbarIndex == 1 ? 14 : null)),
                    Text('Hoodie',
                        style: TextStyle(
                            color: tapbarIndex == 2 ? Colors.black : unactaive,
                            fontSize: tapbarIndex == 2 ? 14 : null)),
                    Text('Shoes',
                        style: TextStyle(
                            color: tapbarIndex == 3 ? Colors.black : unactaive,
                            fontSize: tapbarIndex == 3 ? 14 : null)),
                  ]),
            ),
            body: TabBarView(
              children: <Widget>[
                tshirtsview(),
                jeansview(),
                hoodieview(),
                shoessview(),
              ],
            ),
          ),
        ),
        Material(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
            child: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * .1,
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
                    style: TextStyle(
                        fontFamily: 'Pacifico',
                        fontSize: 25,
                        color: Colors.black),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height * .066,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, CartScreen.id);
                        },
                        child: Icon(
                          Icons.shopping_cart_outlined,
                          size: 30,
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  /*@override
                void initState() { 
                  getCurrentUser();
                  
                }
                getCurrentUser()async{
                 _loggedUser = await _auth.getUser();
                }*/
  Widget tshirtsview() {
    return StreamBuilder<QuerySnapshot>(
        stream: _store.LoadProudct(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = [];
            for (var doc in snapshot.data.documents) {
              var data = doc.data;

              products.add(Product(
                  pId: doc.documentID,
                  pName: data[kpName],
                  pPrice: data[kpPrice],
                  pDescription: data[kpDescription],
                  pCategory: data[kpCategory],
                  pLocation: data[kpLocation]));
              _products = [...products];
              products.clear();
              products = getProductByCategory(ktshirts);
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 1.4),
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ProductInfo.id,
                        arguments: products[index]);
                  },
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Image(
                          fit: BoxFit.fill,
                          image: AssetImage(products[index].pLocation),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Opacity(
                          opacity: .6,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    products[index].pName,
                                    style: TextStyle(
                                        fontFamily: 'Pacifico',
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '\$ ${products[index].pPrice}',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              itemCount: products.length,
            );
          } else {
            // ignore: missing_required_param
            return Center(
              child: Text('loading...'),
            );
          }
        });
  }

  getProductByCategory(String kpCategory) {
    List<Product> products = [];
    for (var product in _products) {
      if (product.pCategory == kpCategory) {
        products.add(product);
      }
    }
    return products;
  }

  Widget jeansview() {
    return StreamBuilder<QuerySnapshot>(
        stream: _store.LoadProudct(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = [];
            for (var doc in snapshot.data.documents) {
              var data = doc.data;

              products.add(Product(
                  pId: doc.documentID,
                  pName: data[kpName],
                  pPrice: data[kpPrice],
                  pDescription: data[kpDescription],
                  pCategory: data[kpCategory],
                  pLocation: data[kpLocation]));
              _products = [...products];
              products.clear();
              products = getProductByCategory(kjeans);
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: .8),
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ProductInfo.id,
                        arguments: products[index]);
                  },
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Image(
                          fit: BoxFit.fill,
                          image: AssetImage(products[index].pLocation),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Opacity(
                          opacity: .6,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    products[index].pName,
                                    style: TextStyle(
                                        fontFamily: 'Pacifico',
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '\$ ${products[index].pPrice}',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              itemCount: products.length,
            );
          } else {
            // ignore: missing_required_param
            return Center(
              child: Text('loading...'),
            );
          }
        });
  }

  Widget hoodieview() {
    return StreamBuilder<QuerySnapshot>(
        stream: _store.LoadProudct(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = [];
            for (var doc in snapshot.data.documents) {
              var data = doc.data;

              products.add(Product(
                  pId: doc.documentID,
                  pName: data[kpName],
                  pPrice: data[kpPrice],
                  pDescription: data[kpDescription],
                  pCategory: data[kpCategory],
                  pLocation: data[kpLocation]));
              _products = [...products];
              products.clear();
              products = getProductByCategory(khoodie);
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: .8),
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ProductInfo.id,
                        arguments: products[index]);
                  },
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Image(
                          fit: BoxFit.fill,
                          image: AssetImage(products[index].pLocation),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Opacity(
                          opacity: .6,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    products[index].pName,
                                    style: TextStyle(
                                        fontFamily: 'Pacifico',
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '\$ ${products[index].pPrice}',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              itemCount: products.length,
            );
          } else {
            // ignore: missing_required_param
            return Center(
              child: Text('loading...'),
            );
          }
        });
  }

  Widget shoessview() {
    return StreamBuilder<QuerySnapshot>(
        stream: _store.LoadProudct(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = [];
            for (var doc in snapshot.data.documents) {
              var data = doc.data;

              products.add(Product(
                  pId: doc.documentID,
                  pName: data[kpName],
                  pPrice: data[kpPrice],
                  pDescription: data[kpDescription],
                  pCategory: data[kpCategory],
                  pLocation: data[kpLocation]));
              _products = [...products];
              products.clear();
              products = getProductByCategory(kshoes);
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 1.2),
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ProductInfo.id,
                        arguments: products[index]);
                  },
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Image(
                          fit: BoxFit.fill,
                          image: AssetImage(products[index].pLocation),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Opacity(
                          opacity: .6,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    products[index].pName,
                                    style: TextStyle(
                                        fontFamily: 'Pacifico',
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '\$ ${products[index].pPrice}',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              itemCount: products.length,
            );
          } else {
            // ignore: missing_required_param
            return Center(
              child: Text('loading...'),
            );
          }
        });
  }
}
