import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:specswear_ecom/model/usermodel.dart';
import 'package:specswear_ecom/provider/product_provider.dart';
import 'package:specswear_ecom/screens/homepage.dart';
import 'package:specswear_ecom/widgets/mybutton.dart';
import 'package:specswear_ecom/widgets/notification_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

ProductProvider? productProvider;

class _ProfileScreenState extends State<ProfileScreen> {
  // final _picker = ImagePicker();
  // Future<void> getImage({required ImageSource source}) async {
  //   PickedFile? image = await _picker.getImage(source: source);
  //   final File file = File(image!.path);
  // }
  File? _pickedImage;
  PickedFile? _image;
  Future<void> getImage({required ImageSource source}) async {
    _image = await ImagePicker().getImage(source: source);
    setState(() {
      if (_image != null) {
        _pickedImage = File(_image!.path);
      }
    });
  }

  void _uploadImage({required File image}) async {
    final user = FirebaseAuth.instance.currentUser;
    Reference storageReference =
        FirebaseStorage.instance.ref().child("UserImage/${user?.uid}");
    await FirebaseStorage.instance
        .ref('uploads/file-to-upload.png')
        .putFile(image);
    // UploadTask uploadTask = storageReference.putFile(image);
    // TaskSnapshot snapshot = await uploadTask.onComplete;
  }

  Future<void> myDialogBox() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  ListTile(
                    leading: Icon(Icons.camera),
                    title: Text("Pick from camera"),
                    onTap: () {
                      getImage(source: ImageSource.camera);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text("Pick from gallery"),
                    onTap: () {
                      getImage(source: ImageSource.gallery);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  bool edit = false;

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    productProvider!.getUserdata();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: edit == true
            ? IconButton(
                onPressed: () {
                  setState(() {
                    edit = false;
                  });
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.redAccent,
                ),
              )
            : IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => HomePage(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
        backgroundColor: Colors.white,
        actions: [
          edit == false
              ? NotificationButton()
              : IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.check,
                    color: Colors.green,
                  ))
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              children: [
                Container(
                  height: 130,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        maxRadius: 65,
                        backgroundImage: AssetImage("images/k1.webp"),
                      )
                    ],
                  ),
                ),
                edit == true
                    ? Padding(
                        padding: EdgeInsets.only(left: 225, top: 88),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              myDialogBox();
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
            Container(
              height: 350,
              // color: Colors.blue,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  edit == true
                      ? Container(
                          height: 250,
                          child: _buildTextFormFieldPart(),
                        )
                      : Container(
                          height: 300,
                          child: _buildSingleContainerPart(),
                        )
                ],
              ),
            ),
            edit == false
                ? MyButton(
                    onPressed: () {
                      setState(() {
                        edit = true;
                      });
                    },
                    name: "Edit Profile",
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormFieldPart() {
    List<UserModel?> userModel = productProvider!.getUserModelList;

    return Column(
      children: userModel.map((e) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildSingleTextField(name: '${e?.userName}'),
            _buildSingleTextField(name: '${e?.userEmail}'),
            _buildSingleTextField(name: '${e?.userPhoneNumber}'),
            _buildSingleTextField(name: '${e?.userGender}'),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildSingleContainerPart() {
    List<UserModel?> userModel = productProvider!.getUserModelList;

    return Column(
      children: userModel.map((e) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildSingleContainer(startText: 'Name', endText: '${e?.userName}'),
            _buildSingleContainer(
                startText: 'Email', endText: '${e?.userEmail}'),
            _buildSingleContainer(
                startText: 'Phone No.', endText: '${e?.userPhoneNumber}'),
            _buildSingleContainer(
                startText: 'Gender', endText: '${e?.userGender}')
          ],
        );
      }).toList(),
    );
  }

  Widget _buildSingleTextField({String? name}) {
    return TextFormField(
      decoration: InputDecoration(
          hintText: "$name",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );
  }

  Widget _buildSingleContainer({String? startText, String? endText}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        width: double.infinity,
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$startText",
              style: TextStyle(fontSize: 17, color: Colors.black45),
            ),
            Text(
              "$endText",
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
