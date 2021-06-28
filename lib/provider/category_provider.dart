import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/product.dart';

class CategoryProvider with ChangeNotifier {
  List<Product?> men = [];
  Product? menData;
  //women
  List<Product?> women = [];
  Product? womenData;
  //Kid
  List<Product?> kids = [];
  Product? kidsData;
  //
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

//women function
  Future<void> getWomenData() async {
    List<Product?> newList = [];
    QuerySnapshot womenSnapShot = await FirebaseFirestore.instance
        .collection("category")
        .doc('y5NuMWFTeQiIkIHmRA9D')
        .collection("women")
        .get();

    womenSnapShot.docs.forEach(
      (element) {
        womenData = Product(
          image: element['image'],
          name: element['name'],
          price: element['price'].toDouble(),
        );
        newList.add(womenData);
      },
    );
    //
    women = newList;
  }

  List<Product?> get getWomenDataList {
    return women;
  }

  //Kids fucntion
  Future<void> getKidsData() async {
    List<Product?> newList = [];
    QuerySnapshot kidsSnapShot = await FirebaseFirestore.instance
        .collection("category")
        .doc('y5NuMWFTeQiIkIHmRA9D')
        .collection("kids")
        .get();

    kidsSnapShot.docs.forEach(
      (element) {
        kidsData = Product(
          image: element['image'],
          name: element['name'],
          price: element['price'].toDouble(),
        );
        newList.add(kidsData);
      },
    );
    //
    kids = newList;
  }

  List<Product?> get getKidsDataList {
    return kids;
  }
}
