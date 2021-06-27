import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  String? email;
  String? password;
  bool obserText = true;
  void validation() async {
    final FormState _form = _formKey.currentState!;
    if (!_form.validate()) {
      print("enter if");
      try {
        print("enter try block");
        final result = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email!, password: password!);
        print(result.user?.uid);
      } on PlatformException catch (e) {
        print('fail');
        print(e.message.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message!),
            duration: Duration(seconds: 3),
          ),
        );
      }
      print('yes');
    } else {
      print('No');
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
            validator: (value) {
              if (value == '') {
                return "Please Enter your Email";
              } else if (!regExp.hasMatch(value!)) {
                return 'Email is invalid';
              }
              return '';
            },
            onChange: (value) {
              setState(() {
                email = value;
              });
            },
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
            validator: (value) {
              if (value == '') {
                return "Please enter your Password";
              } else if (value!.length < 8) {
                return 'Password is too short';
              }
              return '';
            },
            onChange: (value) {
              setState(() {
                password = value;
              });
            },
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
