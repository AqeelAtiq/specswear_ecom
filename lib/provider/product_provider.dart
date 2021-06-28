import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:specswear_ecom/model/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product?> feature = [];
  Product? featureData;
  //
  Future<void> getFeaturedata() async {
    List<Product?> newList = [];
    QuerySnapshot featureSnapShot = await FirebaseFirestore.instance
        .collection("products")
        .doc('npOtqxmDUdXcGsgxDgsN')
        .collection("featureproduct")
        .get();

    featureSnapShot.docs.forEach(
      (element) {
        featureData = Product(
          image: element['image'],
          name: element['name'],
          price: element['price'].toDouble(),
        );
        newList.add(featureData);
      },
    );
    //
    feature = newList;
  }

  List<Product?> get getFeatureDataList {
    return feature;
  }

  //getting archive data
  List<Product?> archieve = [];
  Product? archieveData;
  //
  Future<void> getArchievedata() async {
    List<Product?> newList = [];
    QuerySnapshot archieveSnapShot = await FirebaseFirestore.instance
        .collection("products")
        .doc('npOtqxmDUdXcGsgxDgsN')
        .collection("newarchieve")
        .get();

    archieveSnapShot.docs.forEach(
      (element) {
        archieveData = Product(
          image: element['image'],
          name: element['name'],
          price: element['price'].toDouble(),
        );
        newList.add(archieveData);
      },
    );
    //
    archieve = newList;
  }

  List<Product?> get getArchieveDataList {
    return archieve;
  }
}