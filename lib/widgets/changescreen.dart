import 'package:flutter/material.dart';

class ChangeScreen extends StatelessWidget {
  ChangeScreen(
      {required this.name, required this.onTap, required this.whichAccount});
  final String name;
  final Function() onTap;
  final String whichAccount;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("$whichAccount"),
        SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            "$name",
            style: TextStyle(
                color: Colors.cyan, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
