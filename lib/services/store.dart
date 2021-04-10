import 'package:clothes/models/product.dart';
import 'package:clothes/screens/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Store {
  final Firestore _firestore = Firestore.instance;
  // ignore: non_constant_identifier_names
  Addproduct(Product product) {
    _firestore.collection(kproductCollection).add({
      kpName: product.pName,
      kpPrice: product.pPrice,
      kpDescription: product.pDescription,
      kpCategory: product.pCategory,
      kpLocation: product.pLocation
    });
  }

  // ignore: non_constant_identifier_names
  Stream<QuerySnapshot> LoadProudct() {
    return _firestore.collection(kproductCollection).snapshots();
  }

  // ignore: non_constant_identifier_names
  Stream<QuerySnapshot> LoadOrders() {
    return _firestore.collection(kOrders).snapshots();
  }

  // ignore: non_constant_identifier_names
  Stream<QuerySnapshot> LoadOrderDetails(documentID) {
    return _firestore
        .collection(kOrders)
        .document(documentID)
        .collection(kOrderDetails)
        .snapshots();
  }

  // ignore: non_constant_identifier_names
  deleteProudct(documentId) {
    _firestore.collection(kproductCollection).document(documentId).delete();
  }

  editProduct(data, documentId) {
    _firestore
        .collection(kproductCollection)
        .document(documentId)
        .updateData(data);
  }

  storeOrders(data, List<Product> products) {
    var documentRef = _firestore.collection(kOrders).document();
    documentRef.setData(data);
    for (var product in products) {
      documentRef.collection(kOrderDetails).document().setData({
        kpName: product.pName,
        kpPrice: product.pPrice,
        kpQuantity: product.pQuantity,
        kpLocation: product.pLocation,
        kpCategory: product.pCategory,
        kpDescription: product.pDescription
      });
    }
  }
}
