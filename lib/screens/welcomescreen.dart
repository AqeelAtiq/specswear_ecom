import 'package:flutter/material.dart';
import 'package:specswear_ecom/screens/login.dart';
import 'package:specswear_ecom/screens/signup.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 350,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    //fit: BoxFit.cover,
                    image: AssetImage("images/k1.webp"),
                  ),
                ),
              ),
              Text(
                "Welcome",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Container(
                // color: Colors.blue,
                width: 260,
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ready to Start Shopping SignUp",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "To Get Started",
                      style: TextStyle(fontSize: 18),
                    ),
                    Container(
                      width: 270,
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Color(0xff746bc9),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (ctx) => SignUp()),
                          );
                        },
                        child: Text("SignUp",
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ),
                    Container(
                      width: 250,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Already have account"),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (ctx) => Login()),
                              );
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xff746bc9),
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
