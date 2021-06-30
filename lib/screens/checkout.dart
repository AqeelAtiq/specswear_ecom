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
    double subTotal = 0.0;
    double discount = 3;
    double discountRupess;
    double shipping = 60;
    double total;
    productProvider = Provider.of<ProductProvider>(context);
    productProvider!.getCartModelList.forEach((element) {
      print(element?.price);
      subTotal += (element?.price ?? 0) * (element?.quantity ?? 0);
    });
    print("hello");
    print(productProvider!.getCheckOutModelList.length);

    discountRupess = discount / 100 * subTotal;
    total = subTotal + shipping - discountRupess;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Checkout Page",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
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
            Expanded(
              child: ListView.builder(
                itemCount: productProvider!.getCartModelListLength,
                itemBuilder: (ctx, index) => CartSingleProduct(
                  image: productProvider!.getCartModelList[index]!.image,
                  name: productProvider!.getCartModelList[index]!.name,
                  price: productProvider!.getCartModelList[index]!.price!
                      .toDouble(),
                  quantity: productProvider!.getCartModelList[index]!.quantity,
                  isCount: true,
                ),
              ),
            ),
            Container(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildBottomDetails(
                      startName: 'Price',
                      endName: '${subTotal.toStringAsFixed(2)}'),
                  _buildBottomDetails(
                      startName: 'Discount',
                      endName: '${discount.toStringAsFixed(2)}%'),
                  _buildBottomDetails(
                      startName: 'Shipping',
                      endName: '${shipping.toStringAsFixed(2)}'),
                  _buildBottomDetails(
                      startName: 'Total',
                      endName: '${total.toStringAsFixed(2)}'),
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
