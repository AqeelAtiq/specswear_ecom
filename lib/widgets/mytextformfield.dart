// ignore: unused_import
import 'dart:ffi';

import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  MyTextFormField(
      {required this.name, required this.validator, required this.onChange});
  final String name;
  final String Function(String?) validator;
  final Function(String?) onChange;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onChanged: onChange,
      decoration: InputDecoration(
          hintText: name,
          border: OutlineInputBorder(),
          hintStyle: TextStyle(color: Colors.black54)),
    );
  }
}
