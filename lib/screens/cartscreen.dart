import 'package:flutter/material.dart';
import 'package:specswear_ecom/screens/checkout.dart';

class CartScreen extends StatefulWidget {
  CartScreen({required this.name, required this.image, required this.price});
  final String name;
  final String image;
  final double? price;

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int count = 1;
  final TextStyle mystyle = TextStyle(fontSize: 18);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Cart Page",
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
            "Continous",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => CheckOut(
                    name: widget.name,
                    image: widget.image,
                    price: widget.price),
              ),
            );
          },
        ),
      ),
      body: ListView(
        children: [
          _buildSingleProductCart(),
          _buildSingleProductCart(),
          _buildSingleProductCart(),
          _buildSingleProductCart(),
          _buildSingleProductCart(),
          _buildSingleProductCart(),
          _buildSingleProductCart(),
          _buildSingleProductCart(),
          _buildSingleProductCart(),
          _buildSingleProductCart(),
          _buildSingleProductCart(),
          _buildSingleProductCart(),
        ],
      ),
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
                        color: Color(0xfff2f2f2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              child: Icon(Icons.remove),
                              onTap: () {
                                setState(() {
                                  if (count > 1) {
                                    count--;
                                  } else {
                                    count = 1;
                                  }
                                });
                              },
                            ),
                            Text(
                              "$count",
                              style: mystyle,
                            ),
                            GestureDetector(
                              child: Icon(Icons.add),
                              onTap: () {
                                setState(() {
                                  count++;
                                });
                              },
                            )
                          ],
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
