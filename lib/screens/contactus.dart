import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "If you have any questions about how to place an order online, you may reach us by email.",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Email: ",
              style: TextStyle(fontSize: 30),
              textAlign: TextAlign.left,
            ),
            Text(
              "aqeelatiq.arain@gmail.com\nmaliksufiantariq@gmail.com \niqraafzal@gmail.com  ",
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
