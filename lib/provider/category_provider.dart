import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:specswear_ecom/screens/homepage.dart';
import '../model/product.dart';

class CategoryProvider with ChangeNotifier {
  List<Product?> men = [];
  Product? menData;
  Future<void> getMenData() async {
    List<Product?> newList = [];
    QuerySnapshot menSnapShot = await FirebaseFirestore.instance
        .collection("category")
        .doc('y5NuMWFTeQiIkIHmRA9D')
        .collection("men")
        .get();

    menSnapShot.docs.forEach(
      (element) {
        menData = Product(
          image: element['image'],
          name: element['name'],
          price: element['price'].toDouble(),
        );
        newList.add(menData);
      },
    );
    //
    men = newList;
  }

  List<Product?> get getMenDataList {
    return men;
  }
}
