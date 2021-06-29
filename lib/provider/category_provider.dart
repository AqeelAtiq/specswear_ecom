import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:specswear_ecom/model/categoryicon.dart';
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
  //category icon
  List<CategoryIcon?> menIcon = [];
  CategoryIcon? menIconData;

  List<CategoryIcon?> womenIcon = [];
  CategoryIcon? womenIconData;

  List<CategoryIcon?> kidsIcon = [];
  CategoryIcon? kidsIconData;
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

  //getting icon for men category button
  Future<void> getMenIconData() async {
    List<CategoryIcon?> newList = [];

    QuerySnapshot menIconSnapShot = await FirebaseFirestore.instance
        .collection("categoryicon")
        .doc('dwXNIhhXm5x42rW8Odgi')
        .collection("menicon")
        .get();

    menIconSnapShot.docs.forEach(
      (element) {
        menIconData = CategoryIcon(
          image: element['image'],
        );
        newList.add(menIconData);
      },
    );
    //
    menIcon = newList;
  }

  List<CategoryIcon?> get getMenIconDataList {
    return menIcon;
  }

  //getting icon for women category button
  Future<void> getWomenIconData() async {
    List<CategoryIcon?> newList = [];

    QuerySnapshot womenIconSnapShot = await FirebaseFirestore.instance
        .collection("categoryicon")
        .doc('dwXNIhhXm5x42rW8Odgi')
        .collection("womenicon")
        .get();

    womenIconSnapShot.docs.forEach(
      (element) {
        womenIconData = CategoryIcon(
          image: element['image'],
        );
        newList.add(womenIconData);
      },
    );
    //
    womenIcon = newList;
  }

  List<CategoryIcon?> get getWomenIconDataList {
    return womenIcon;
  }

  //getting icon for Kids category button
  Future<void> getKidsIconData() async {
    List<CategoryIcon?> newList = [];

    QuerySnapshot kidsIconSnapShot = await FirebaseFirestore.instance
        .collection("categoryicon")
        .doc('dwXNIhhXm5x42rW8Odgi')
        .collection("kidsicon")
        .get();

    kidsIconSnapShot.docs.forEach(
      (element) {
        kidsIconData = CategoryIcon(
          image: element['image'],
        );
        newList.add(kidsIconData);
      },
    );
    //
    kidsIcon = newList;
  }

  List<CategoryIcon?> get getKidsIconDataList {
    return kidsIcon;
  }
}
