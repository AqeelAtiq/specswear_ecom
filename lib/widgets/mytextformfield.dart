// ignore: unused_import
import 'dart:ffi';

import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  MyTextFormField({required this.name, required this.controller});
  final String name;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: name,
          border: OutlineInputBorder(),
          hintStyle: TextStyle(color: Colors.black54)),
    );
  }
}
