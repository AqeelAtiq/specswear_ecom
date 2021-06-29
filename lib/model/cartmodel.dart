import 'package:flutter/material.dart';

class CartModel {
  final String? name;
  final String? image;
  final int? quantity;
  final double? price;
  CartModel({
    required this.image,
    required this.name,
    required this.price,
    required this.quantity,
  });
}
