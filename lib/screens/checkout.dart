import 'package:flutter/material.dart';

class CheckOut extends StatefulWidget {
  CheckOut({required this.name, required this.image, required this.price});
  final String name;
  final String image;
  final double price;

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  int count = 1;

  final TextStyle mystyle = TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Checkout Page",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_none,
              color: Colors.black,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        width: 100,
        height: 70,
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.only(bottom: 10),
        // ignore: deprecated_member_use
        child: RaisedButton(
          color: Color(0xff746bc9),
          child: Text(
            "Buy",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          onPressed: () {},
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSingleProductCart(),
                _buildSingleProductCart(),
                Container(
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildBottomDetails(startName: 'Price', endName: '1500'),
                      _buildBottomDetails(startName: 'Discount', endName: '3%'),
                      _buildBottomDetails(
                          startName: 'Shipping', endName: '100'),
                      _buildBottomDetails(startName: 'Total', endName: '1600'),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
//Building bottom details

  Widget _buildBottomDetails({String? startName, String? endName}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$startName",
          style: mystyle,
        ),
        Text(
          "Rs. ${endName}",
          style: mystyle,
        ),
      ],
    );
  }

//building cart product
  Widget _buildSingleProductCart() {
    return Container(
      height: 150,
      width: double.infinity,
      child: Card(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 130,
                width: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/${widget.image}"),
                  ),
                ),
              ),
              Container(
                height: 140,
                width: 200,
                child: ListTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${widget.name}"),
                      Text("Kids"),
                      Text(
                        "Rs.${widget.price.toString()}",
                        style: TextStyle(
                            color: Color(0xff9b96d6),
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        height: 35,
                        width: 100,
                        //color: Color(0xfff2f2f2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text("Quantity"), Text("1")],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      )),
    );
  }
}
