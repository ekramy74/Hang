import 'package:clothes/models/product.dart';
import 'package:clothes/screens/const.dart';
import 'package:clothes/services/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OrderDetails extends StatelessWidget {
  static String id = 'OrderDetailsScreen';

  Store _store = Store();
  @override
  Widget build(BuildContext context) {
    // final double screenheight = MediaQuery.of(context).size.height;

    String documentID = ModalRoute.of(context).settings.arguments;
    final double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: _store.LoadOrderDetails(documentID),
          // ignore: missing_return
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Product> products = [];
              for (var doc in snapshot.data.documents) {
                var data = doc.data;
                products.add(Product(
                    pName: data[kpName],
                    pDescription: data[kpDescription],
                    pQuantity: data[kpQuantity],
                    pPrice: data[kpPrice],
                    pLocation: data[kpLocation]));
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Container(
                                height: MediaQuery.of(context).size.height * .2,
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 10),
                                      child: CircleAvatar(
                                        radius: screenheight * .15 / 2,
                                        backgroundImage: AssetImage(
                                            products[index].pLocation),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Name : ${products[index].pName}',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'QTY : ${products[index].pQuantity}',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Price = ${products[index].pPrice} \EGP',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        itemCount: products.length,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 50),
                          child: RaisedButton(
                            child: Text('Confirm'),
                            textColor: Colors.white,
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 50),
                          child: RaisedButton(
                            child: Text('Delete'),
                            textColor: Colors.white,
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
            } else {
              return Text('Loading order Details...');
            }
          }),
    );
  }
}
