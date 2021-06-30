import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:specswear_ecom/widgets/cartsingleproduct.dart';
import '../provider/product_provider.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

ProductProvider? productProvider;

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Cart Page",
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
            "Continous",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          onPressed: () {},
        ),
      ),
      body: ListView.builder(
        itemCount: productProvider!.getCartModelListLength,
        itemBuilder: (ctx, index) => CartSingleProduct(
            image: productProvider!.getCartModelList[index]!.image,
            name: productProvider!.getCartModelList[index]!.name,
            price: productProvider!.getCartModelList[index]!.price!.toDouble(),
            quantity: productProvider!.getCartModelList[index]!.quantity),
      ),
    );
  }

//building cart product

}
