import 'package:flutter/material.dart';

class UserModel {
  UserModel(
      {required this.userEmail,
      required this.userGender,
      required this.userName,
      required this.userPhoneNumber,
      required this.userAddress});
  String userName;
  String userEmail;
  String userPhoneNumber;
  String userGender;
  String userAddress;
}
