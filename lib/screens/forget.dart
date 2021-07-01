import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Forget extends StatelessWidget {
  String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Text(
                "Enter your email.We will send you link to reset your password"),
            TextField(
              style: TextStyle(color: Colors.black),
              onChanged: (value) {
                //Do something with the user input.
                email = value;
              },
              decoration: InputDecoration(
                hintText: 'Enter your email',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () async {
                    try {
                      FirebaseAuth.instance
                          .sendPasswordResetEmail(email: email);
                      print("Email sent");
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text('Email sent. Check your Email'),
                        duration: const Duration(seconds: 3),
                      ));
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text("Reset Email"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
