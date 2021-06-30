import 'package:flutter/material.dart';
import 'package:specswear_ecom/widgets/mybutton.dart';
import 'package:specswear_ecom/widgets/notification_button.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool edit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            : Container(),
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
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Icon(
                              Icons.edit,
                              color: Colors.black,
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
                          height: 300,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildSingleTextField(name: 'Aqeel'),
                              _buildSingleTextField(
                                  name: 'aqeelatiq.arain@gmail.com'),
                              _buildSingleTextField(name: '03111234567'),
                              _buildSingleTextField(name: 'Male'),
                            ],
                          ),
                        )
                      : Container(
                          height: 300,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildSingleContainer(
                                  startText: 'Name', endText: 'Aqeel Atiq'),
                              _buildSingleContainer(
                                  startText: 'Email',
                                  endText: 'aqeelatiq.arain@gmail.com'),
                              _buildSingleContainer(
                                  startText: 'Phone No.',
                                  endText: '03111234567'),
                              _buildSingleContainer(
                                  startText: 'Gender', endText: 'Male')
                            ],
                          ),
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
