import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  SingleProduct({required this.name, required this.price, required this.image});
  final String name;
  final double? price;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 250,
        width: 180,
        child: Column(children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Container(
              height: 170,
              width: 160,
              decoration: BoxDecoration(
                //  color: Colors.blueGrey,
                image: DecorationImage(
                  // fit: BoxFit.fill,
                  image: NetworkImage(image),
                ),
              ),
            ),
          ),
          Text(
            "Rs. ${price.toString()}",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xff9b96d6),
            ),
          ),
          Text(
            "$name",
            style: TextStyle(fontSize: 17),
          )
        ]),
      ),
    );
  }
}
