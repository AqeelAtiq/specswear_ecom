import 'package:flutter/material.dart';
import 'package:specswear_ecom/model/product.dart';
import 'package:specswear_ecom/screens/detailscreen.dart';
import 'package:specswear_ecom/widgets/singleproduct.dart';

class ListProduct extends StatelessWidget {
  ListProduct({required this.name, required this.snapShot});
  final String name;
  final List<Product?> snapShot;
  Widget _buildMyGridView(context) {
    final Orientation orientation = MediaQuery.of(context).orientation;

    return Container(
      height: 700,
      child: GridView.count(
        crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
        childAspectRatio: orientation == Orientation.portrait ? 0.7 : 0.9,
        scrollDirection: Axis.vertical,
        children: snapShot
            .map(
              (e) => GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (ctx) => DetailScreen(
                            image: "${e?.image}",
                            name: "${e?.name}",
                            price: e?.price,
                            desc: "${e?.desc}",
                          )));
                },
                child: SingleProduct(
                  price: e?.price,
                  image: "${e?.image}",
                  name: "${e?.name}",
                  desc: "${e?.desc}",
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(snapShot);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(Icons.search, color: Colors.black),
        //   ),
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(Icons.notifications_none, color: Colors.black),
        //   )
        // ],
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
                Container(height: 700, child: _buildMyGridView(context))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
