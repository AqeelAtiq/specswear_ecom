import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:specswear_ecom/provider/product_provider.dart';

class CartSingleProduct extends StatefulWidget {
  final String? image;
  final String? name;
  final double? price;
  int? quantity;
  bool? isCount;
  CartSingleProduct(
      {required this.image,
      required this.name,
      required this.price,
      this.quantity,
      this.isCount});

  @override
  _CartSingleProductState createState() => _CartSingleProductState();
}

TextStyle mystyle = TextStyle(fontSize: 18);
ProductProvider? productProvider;

class _CartSingleProductState extends State<CartSingleProduct> {
  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    productProvider!.getCheckOutData(
      name: widget.name,
      price: widget.price,
      quantity: widget.quantity,
      image: widget.image,
    );

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
                    image: NetworkImage("${widget.image}"),
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
                          child: widget.isCount == false
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      child: Icon(Icons.remove),
                                      onTap: () {
                                        setState(() {
                                          if (widget.quantity! > 1) {
                                            widget.quantity =
                                                widget.quantity! - 1;
                                            productProvider!.getCheckOutData(
                                              name: widget.name,
                                              price: widget.price,
                                              quantity: widget.quantity,
                                              image: widget.image,
                                            );
                                          } else {
                                            widget.quantity = 1;
                                          }
                                        });
                                      },
                                    ),
                                    Text(
                                      "${widget.quantity}",
                                      style: mystyle,
                                    ),
                                    GestureDetector(
                                      child: Icon(Icons.add),
                                      onTap: () {
                                        setState(() {
                                          widget.quantity =
                                              widget.quantity! + 1;
                                          productProvider!.getCheckOutData(
                                            name: widget.name,
                                            price: widget.price,
                                            quantity: widget.quantity,
                                            image: widget.image,
                                          );
                                        });
                                      },
                                    )
                                  ],
                                )
                              : Row(
                                  children: [
                                    Text("Quantity"),
                                    Text(widget.quantity.toString())
                                  ],
                                )),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      )),
    );
    ;
  }
}
