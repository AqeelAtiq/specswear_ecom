import 'package:flutter/material.dart';

class PasswordTextFormField extends StatelessWidget {
  PasswordTextFormField(
      {required this.name,
      required this.onTap,
      required this.validator,
      required this.obserText,
      required this.onChange});
  final String name;
  final bool obserText;
  final void Function() onTap;
  final String Function(String?) validator;
  final void Function(String?) onChange;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: validator,
        obscureText: obserText,
        onChanged: onChange,
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
