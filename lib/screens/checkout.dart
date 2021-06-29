import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:specswear_ecom/provider/product_provider.dart';
import 'package:specswear_ecom/widgets/cartsingleproduct.dart';

class CheckOut extends StatefulWidget {
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  ProductProvider? productProvider;
  int count = 1;

  final TextStyle mystyle = TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
                itemCount: productProvider!.getCartModelListLength,
                itemBuilder: (ctx, index) {
                  return CartSingleProduct(
                    image: productProvider!.getCartModelList[index]!.image,
                    name: productProvider!.getCartModelList[index]!.name,
                    price: productProvider!.getCartModelList[index]!.price!
                        .toDouble(),
                    quantity:
                        productProvider!.getCartModelList[index]!.quantity,
                  );
                }),
            Container(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildBottomDetails(startName: 'Price', endName: '1500'),
                  _buildBottomDetails(startName: 'Discount', endName: '3%'),
                  _buildBottomDetails(startName: 'Shipping', endName: '100'),
                  _buildBottomDetails(startName: 'Total', endName: '1600'),
                ],
              ),
            )
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
          "Rs. $endName",
          style: mystyle,
        ),
      ],
    );
  }

//building cart product
}
