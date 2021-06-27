import 'package:flutter/material.dart';
import 'package:specswear_ecom/model/product.dart';
import 'package:specswear_ecom/screens/homepage.dart';
import 'package:specswear_ecom/widgets/singleproduct.dart';

class ListProduct extends StatelessWidget {
  ListProduct({required this.name, required this.snapShot});
  final String name;
  final List<Product> snapShot;
  @override
  Widget build(BuildContext context) {
    print(snapShot);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => HomePage(),
              ),
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: Colors.black),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none, color: Colors.black),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                  height: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "$name",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 700,
                  child: GridView.count(
                    crossAxisCount: 2,
                    scrollDirection: Axis.vertical,
                    children: snapShot
                        .map(
                          (e) => SingleProduct(
                              name: e.name,
                              price: e.price.toDouble(),
                              image: e.image),
                        )
                        .toList(),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
