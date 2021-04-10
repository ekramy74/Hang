import 'package:clothes/models/product.dart';
import 'package:clothes/screens/cartitem.dart';
import 'package:clothes/screens/const.dart';
import 'package:clothes/screens/product_info.dart';
import 'package:clothes/services/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static String id = 'CartScreen';
  @override
  Widget build(BuildContext context) {
    List<Product> products = Provider.of<CartItem>(context).products;
    final double screenheight = MediaQuery.of(context).size.height;
    final double screenwidth = MediaQuery.of(context).size.width;
    final double appbarheight = AppBar().preferredSize.height;
    final double statusbarheight = MediaQuery.of(context).padding.top;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
        ),
        title: Text(
          'My Cart',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          LayoutBuilder(builder: (context, constrains) {
            if (products.isNotEmpty) {
              return Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                        elevation: 10,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Container(
                            height: screenheight * .14,
                            //color: Colors.white,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                              colors: [Colors.white, Colors.blueGrey[400]],
                            )),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: CircleAvatar(
                                    radius: screenheight * .12 / 2,
                                    backgroundImage:
                                        AssetImage(products[index].pLocation),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              products[index].pName,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              ' ${products[index].pPrice}\EGP',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'Qty:  ${products[index].pQuantity.toString()}',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            deleteproducts(
                                                context, products[index]);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: Icon(
                                              Icons.delete_outline,
                                              size: 35,
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    editproducts(context, products[index]);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Icons.edit_outlined,
                                      size: 35,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: products.length,
                ),
              );
            } else {
              return Container(
                height: screenheight - statusbarheight - appbarheight,
                child: Center(
                  child: Text('The Cart is empty'),
                ),
              );
            }
          }),
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: ButtonTheme(
              minWidth: screenwidth * .5,
              height: screenheight * .07,
              child: RaisedButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onPressed: () {
                  showCustomDialog(products, context);
                },
                icon: Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.white,
                ),
                label: Text(
                  'order',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void deleteproducts(context, product) {
    Provider.of<CartItem>(context, listen: false).deleteProduct(product);
  }

  void editproducts(context, product) {
    Navigator.pop(context);
    Provider.of<CartItem>(context, listen: false).deleteProduct(product);
    Navigator.pushNamed(context, ProductInfo.id, arguments: product);
  }

  void showCustomDialog(List<Product> products, context) async {
    var price = getTotalPrice(products);
    var address;
    var firstname;
    var lastname;
    var mobileNumb;
    String hint;
    // ignore: missing_return
    String _errormsg(String str) {
      switch (hint) {
        case 'Enter your first name':
          return 'kindlly enter you first name!';

          break;
        case 'Enter your Last name':
          return 'kindlly enter your last name!';
        case 'Enter your address':
          return 'kindlly enter your address!';

        case 'Enter your Mobile number':
          return 'kindlly enter your mobile number!';
      }
    }

    AlertDialog alertDialog = AlertDialog(
      title: Text('Checkout'),
      scrollable: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      elevation: 0,
      content: Column(
        children: [
          TextFormField(
            // ignore: missing_return
            validator: (value) {
              if (value.isEmpty) {
                return _errormsg(hint);
              }
            },
            onChanged: (value) {
              firstname = value;
            },
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: 'Enter your first name',
                prefixIcon: Icon(Icons.person_outline),
                labelText: 'First name',
                filled: true,
                fillColor: Colors.transparent,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(20),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(20),
                )),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            // ignore: missing_return
            validator: (value) {
              if (value.isEmpty) {
                return _errormsg(hint);
              }
            },
            onChanged: (value) {
              lastname = value;
            },
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: 'Enter your Last name',
                prefixIcon: Icon(Icons.person),
                labelText: 'Last name',
                filled: true,
                fillColor: Colors.transparent,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(20),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(20),
                )),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            // ignore: missing_return
            validator: (value) {
              if (value.isEmpty) {
                return _errormsg(hint);
              }
            },
            onChanged: (value) {
              address = value;
            },
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: 'Enter your address',
                prefixIcon: Icon(Icons.alternate_email_outlined),
                labelText: 'Address',
                filled: true,
                fillColor: Colors.transparent,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(20),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(20),
                )),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            // ignore: missing_return
            validator: (value) {
              if (value.isEmpty) {
                return _errormsg(hint);
              }
            },
            onChanged: (value) {
              mobileNumb = value;
            },
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: 'Enter your Mobile number',
                prefixIcon: Icon(Icons.phone_android_outlined),
                labelText: 'Mobile number',
                filled: true,
                fillColor: Colors.transparent,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(20),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(20),
                )),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Total price: \EGP $price',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Builder(
            builder: (context) => ButtonTheme(
              minWidth: MediaQuery.of(context).size.width * .5,
              height: MediaQuery.of(context).size.height * .06,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Builder(
                  builder: (context) => FlatButton(
                    onPressed: () {
                      try {
                        Store _store = Store();
                        _store.storeOrders({
                          kFirstName: firstname,
                          kLastName: lastname,
                          kAddress: address,
                          kMobileNumb: mobileNumb,
                          kTotalPrice: price,
                        }, products);
                      } catch (ex) {
                        print(ex.message);
                      }
                      Navigator.pop(context);
                    },
                    color: Colors.transparent,
                    splashColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(color: Colors.black, width: 1.5),
                    ),
                    child: Text(
                      'Checkout'.toUpperCase(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    await showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }

  getTotalPrice(List<Product> products) {
    double price = 0;
    for (var product in products) {
      price += product.pQuantity * double.parse(product.pPrice);
    }
    return price;
  }
}
