import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:specswear_ecom/model/cartmodel.dart';
import 'package:specswear_ecom/model/checkmodel.dart';
import 'package:specswear_ecom/model/product.dart';
import 'package:specswear_ecom/model/usermodel.dart';

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
            desc: element['desc']);
        newList.add(featureData);
      },
    );
    //
    feature = newList;
  }

  List<Product?> get getFeatureDataList {
    return feature;
  }

//getting home feature data
  List<Product?> homeFeature = [];
  Product? homeFeatureData;
  //
  Future<void> getHomeFeaturedata() async {
    List<Product?> newList = [];
    QuerySnapshot homeFeatureSnapShot =
        await FirebaseFirestore.instance.collection("homefeature").get();

    homeFeatureSnapShot.docs.forEach(
      (element) {
        homeFeatureData = Product(
            image: element['image'],
            name: element['name'],
            price: element['price'].toDouble(),
            desc: element['desc']);
        newList.add(homeFeatureData);
      },
    );
    //
    homeFeature = newList;
    notifyListeners();
  }

  List<Product?> get getHomeFeatureDataList {
    return homeFeature;
  }

//
//getting home archieve data here
  List<Product?> homeArchieve = [];
  Product? homeArchieveData;
  //
  Future<void> getHomeArchievedata() async {
    List<Product?> newList = [];
    QuerySnapshot homeArchieveSnapShot =
        await FirebaseFirestore.instance.collection("homearchieve").get();

    homeArchieveSnapShot.docs.forEach(
      (element) {
        homeArchieveData = Product(
            image: element['image'],
            name: element['name'],
            price: element['price'].toDouble(),
            desc: element['desc']);
        newList.add(homeArchieveData);
      },
    );
    //
    homeArchieve = newList;
    notifyListeners();
  }

  List<Product?> get getHomeArchieveDataList {
    return homeArchieve;
  }

//
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
            desc: element['desc']);
        newList.add(archieveData);
      },
    );
    //
    archieve = newList;
    notifyListeners();
  }

  List<Product?> get getArchieveDataList {
    return archieve;
  }

  //Playing with Cart
  List<CartModel?> cartModelList = [];
  CartModel? cartModel;
  void getCartData(
      {String? name, String? image, int? quantity, double? price}) {
    cartModel = CartModel(
      image: image,
      name: name,
      price: price,
      quantity: quantity,
    );
    cartModelList.add(cartModel);
  }

  List<CartModel?> get getCartModelList {
    return List.from(cartModelList);
  }

  int get getCartModelListLength {
    return cartModelList.length;
  }

  //Playing with Checkout model
  List<CheckOutModel?> checkOutModelList = [];
  CheckOutModel? checkOutModel;
  void getCheckOutData(
      {String? name, String? image, int? quantity, double? price}) {
    checkOutModel = CheckOutModel(
      image: image,
      name: name,
      price: price,
      quantity: quantity,
    );
    checkOutModelList.add(checkOutModel);
  }

  List<CheckOutModel?> get getCheckOutModelList {
    return checkOutModelList;
  }

  int get getCheckOutModelListLength {
    return checkOutModelList.length;
  }

  //
//notification
  List<String> notificationList = [];
  void addnotification(String notification) {
    notificationList.add(notification);
  }

  int get getNotificationIndex {
    return notificationList.length;
  }

  //getting user data
  List<UserModel?> userModelList = [];

  UserModel? userModel;

  Future<void> getUserdata() async {
    List<UserModel?> newList = [];

    final currentUser = FirebaseAuth.instance.currentUser;
    QuerySnapshot userSnapShot =
        await FirebaseFirestore.instance.collection("User").get();

    userSnapShot.docs.forEach(
      (element) {
        if (currentUser!.uid == element['UserId']) {
          print("we have current user");
          userModel = UserModel(
              userEmail: element['UserEmail'],
              userGender: element['UserGender'],
              userName: element['UserName'],
              userAddress: element['UserAddress'],
              userPhoneNumber: element['PhoneNumber']);
          print(userModel?.userEmail);
          newList.add(userModel);
        }
        userModelList = newList;
      },
    );
  }

  List<UserModel?> get getUserModelList {
    return userModelList;
  }

  void deleteCartProduct(int index) {
    cartModelList.removeAt(index);
    print("//");

    print(index);
    print("//");
    notifyListeners();
  }
}
