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
// String? email, userName, phoneNumber;
// String? password;
bool isMale = true;
bool obserText = true;
final TextEditingController email = TextEditingController();
final TextEditingController phoneNumber = TextEditingController();
final TextEditingController password = TextEditingController();
final TextEditingController userName = TextEditingController();

class _SignUpState extends State<SignUp> {
  void validation() async {
    if (userName.text.isEmpty &&
        email.text.isEmpty &&
        password.text.isEmpty &&
        phoneNumber.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("All fields are empty")));
    } else if (userName.text.length < 7) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Name must be 6")));
    } else if (email.text.isEmpty) {
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
    } else if (phoneNumber.text.length < 11) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("phone number must be 11")));
    } else {
      try {
        final result = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email.text, password: password.text);
        FirebaseFirestore.instance
            .collection("User")
            .doc(result.user?.uid)
            .set({
          "UserName": userName.text,
          "UserId": result.user?.uid,
          "UserEmail": email.text,
          "UserGender": isMale == true ? 'Male' : false,
          "PhoneNumber": phoneNumber.text,
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
    }
  }

  // void validation() async {
  //   final FormState _form = _formKey.currentState!;
  //   if (!_form.validate()) {
  //     print('enter try block');

  //     try {
  //       final result = await FirebaseAuth.instance
  //           .createUserWithEmailAndPassword(email: email!, password: password!);
  //       FirebaseFirestore.instance
  //           .collection("User")
  //           .doc(result.user?.uid)
  //           .set({
  //         "UserName": userName,
  //         "UserId": result.user?.uid,
  //         "UserEmail": email,
  //         "UserGender": isMale == true ? 'Male' : false,
  //         "PhoneNumber": phoneNumber,
  //       });
  //       print(result.user?.uid);
  //     } on PlatformException catch (e) {
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

  Widget _buildAllTextFormField() {
    return Container(
      height: 420,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
//UserName
          MyTextFormField(
            name: 'User Name',
            controller: userName,
          ),
          //Email
          MyTextFormField(
            name: "Enter your Email",
            controller: email,
          ),
          //password
          PasswordTextFormField(
              name: "Enter your Password",
              controller: password,
              onTap: () {
                setState(() {
                  obserText = !obserText;
                });
                Focus.of(context).unfocus();
              },
              obserText: obserText),
          //gender
          GestureDetector(
            onTap: () {
              print("tapped is ");
              print(isMale);
              setState(() {
                isMale = !isMale;
              });
            },
            child: Container(
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Center(
                child: Row(
                  children: [
                    Text(
                      isMale ? "Male" : "Female",
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Phone Number field
          MyTextFormField(
            name: "Phone Number",
            controller: phoneNumber,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomPart() {
    return Container(
      //color: Colors.blue,
      height: 500,
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
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Container(
                child: Column(
                  children: [
                    Container(
                      // color: Colors.blue,
                      height: 120,
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
          ],
        ),
      ),
    );
  }
}
