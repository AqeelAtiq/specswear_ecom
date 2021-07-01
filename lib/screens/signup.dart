import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:specswear_ecom/screens/login.dart';
import 'package:specswear_ecom/widgets/changescreen.dart';
import 'package:specswear_ecom/widgets/mybutton.dart';
import 'package:specswear_ecom/widgets/mytextformfield.dart';
import 'package:specswear_ecom/widgets/passwordtextformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

RegExp regExp = new RegExp(p);

class _SignUpState extends State<SignUp> {
  String? email, userName;
  String? password;
  bool obserText = true;
  void validation() async {
    final FormState _form = _formKey.currentState!;
    if (!_form.validate()) {
      print('enter try block');

      try {
        final result = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email!, password: password!);
        FirebaseFirestore.instance
            .collection("User")
            .doc(result.user?.uid)
            .set({
          "UserName": userName,
          "UserId": result.user?.uid,
          "UserEmail": email,
        });
        print(result.user?.uid);
      } on PlatformException catch (e) {
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

  Widget _buildAllTextFormField() {
    return Container(
      height: 340,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
//UserName
          MyTextFormField(
            name: 'User Name',
            validator: (value) {
              if (value == '') {
                return "Please enter your Username";
              } else if (value!.length < 6) {
                return 'Username is too short';
              }
              return '';
            },
            onChange: (value) {
              userName = value;
            },
          ),
          //Email
          MyTextFormField(
            name: "Enter your Email",
            validator: (value) {
              if (value == '') {
                return "Please enter your Email";
              } else if (!regExp.hasMatch(value!)) {
                return 'Email is invalid';
              }
              return '';
            },
            onChange: (value) {
              setState(() {
                email = value;
                print(email);
              });
            },
          ),
          //password
          PasswordTextFormField(
              name: "Enter your Password",
              onTap: () {
                setState(() {
                  obserText = !obserText;
                });
                Focus.of(context).unfocus();
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
                  print(password);
                });
              },
              obserText: obserText),
          //gender
          Container(
            height: 60,
            width: double.infinity,
            color: Colors.blue,
          ),
          // Phone Number field
          MyTextFormField(
            name: "Phone Number",
            validator: (value) {
              if (value == '') {
                return "Please enter your Phone Number";
              } else if (value!.length < 11) {
                return 'Enter Valid Phone Number';
              }
              return '';
            },
            onChange: (value) {},
          ),
        ],
      ),
    );
  }

  Widget _buildBottomPart() {
    return Container(
      //color: Colors.blue,
      height: 408,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildAllTextFormField(),
          //register button
          MyButton(
            onPressed: () {
              validation();
            },
            name: 'Sign Up',
          ),
          //change screen
          ChangeScreen(
              name: "Login",
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => Login(),
                  ),
                );
              },
              whichAccount: "I have Already Account")
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            child: Column(
              children: [
                Container(
                  // color: Colors.blue,
                  height: 220,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Register',
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 0,
                ),
                //bottom
                _buildBottomPart(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
