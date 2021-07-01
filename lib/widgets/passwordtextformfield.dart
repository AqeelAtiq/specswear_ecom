import 'package:flutter/material.dart';

class PasswordTextFormField extends StatelessWidget {
  PasswordTextFormField(
      {required this.name,
      required this.onTap,
      required this.obserText,
      required this.controller});
  final String name;
  final bool obserText;
  final void Function() onTap;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        obscureText: obserText,
        decoration: InputDecoration(
          hintText: '$name',
          border: OutlineInputBorder(),
          hintStyle: TextStyle(color: Colors.black54),
          suffixIcon: GestureDetector(
            onTap: onTap,
            child: Icon(
              obserText ? Icons.visibility : Icons.visibility_off,
              color: Colors.black,
            ),
          ),
        ));
  }
}
