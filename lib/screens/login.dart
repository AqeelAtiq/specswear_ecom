import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:specswear_ecom/screens/homepage.dart';
import 'package:specswear_ecom/screens/signup.dart';
import 'package:specswear_ecom/widgets/changescreen.dart';
import 'package:specswear_ecom/widgets/mybutton.dart';
import 'package:specswear_ecom/widgets/mytextformfield.dart';
import 'package:specswear_ecom/widgets/passwordtextformfield.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

RegExp regExp = new RegExp(p);

class _LoginState extends State<Login> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  bool obserText = true;
  // void validation() async {
  //   final FormState _form = _formKey.currentState!;
  //   if (!_form.validate()) {
  //     print("enter if");
  //     try {
  //       print("enter try block");
  //       final result = await FirebaseAuth.instance
  //           .signInWithEmailAndPassword(email: email!, password: password!);
  //       print(result.user?.uid);
  //     } on PlatformException catch (e) {
  //       print('fail');
  //       print(e.message.toString());
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(e.message!),
  //           duration: Duration(seconds: 3),
  //         ),
  //       );
  //     }
  //     print('yes');
  //   } else {
  //     print('No');
  //   }
  // }
  void validation() async {
    if (email.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Email is empty")));
    } else if (!regExp.hasMatch(email.text)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Enter a valid email")));
    } else if (password.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("password is empty")));
    } else if (password.text.length < 8) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("password is too short")));
    } else {
      try {
        print("enter try block");
        final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email.text, password: password.text);
        print(result.user?.uid);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => HomePage(),
          ),
        );
      } on PlatformException catch (e) {
        print('fail');
        print(e.message.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("e.message!"),
            duration: Duration(seconds: 3),
          ),
        );
      }
      print('yes');
    }
  }

  Widget _buildAllPart() {
    return Container(
      // color: Colors.lightBlue,
      width: double.infinity,
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Login",
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          // email
          MyTextFormField(
            name: 'Enter your Email',
            controller: email,
          ),
          //Password
          PasswordTextFormField(
            obserText: obserText,
            name: "Enter your Password",
            onTap: () {
              print("tapp");
              setState(() {
                obserText = !obserText;
              });
              //Focus.of(context).unfocus();
            },
            controller: password,
          ),
          //button
          MyButton(
            onPressed: () {
              validation();
            },
            name: 'Login',
          ),
          //changescreen
          ChangeScreen(
              name: 'Sign Up',
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => SignUp(),
                  ),
                );
              },
              whichAccount: 'I have not account')
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildAllPart(),
            ],
          ),
        ),
      ),
    );
  }
}
