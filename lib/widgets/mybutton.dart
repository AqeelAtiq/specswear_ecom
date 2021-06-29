import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  MyButton({this.name, required this.onPressed});
  final String? name;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: double.infinity,
      // ignore: deprecated_member_use
      child: RaisedButton(
        onPressed: onPressed,
        child: Text("$name"),
        color: Color(0xff746bc9),
      ),
    );
  }
}
