import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:specswear_ecom/provider/product_provider.dart';
import 'package:specswear_ecom/screens/cartscreen.dart';
import 'package:specswear_ecom/widgets/mybutton.dart';
import 'package:specswear_ecom/widgets/notification_button.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen(
      {required this.image,
      required this.name,
      required this.price,
      this.quantity});
  final String image;
  final String name;
  final double? price;
  final int? quantity;

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  ProductProvider? productProvider;
  int count = 1;
  final TextStyle mystyle = TextStyle(fontSize: 18);

  Widget _buildSizedProduct({String? name}) {
    return Container(
      height: 60,
      width: 60,
      color: Color(0xfff2f2f2),
      child: Center(
        child: Text(
          "$name",
          style: TextStyle(fontSize: 17),
        ),
      ),
    );
  }

  Widget _buildColorProduct({Color? color}) {
    return Container(
      height: 60,
      width: 60,
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Detail Page",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [NotificationButton()],
      ),
      body: Container(
        child: ListView(
          children: [
            Column(
              children: [
                Column(
                  children: [
                    //Building Image
                    _buildImage(),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //building Name to description part here
                          _buildNametoDescriptionPart(),
                          //buildong description part
                          _buildDescription(),
                          SizedBox(
                            height: 15,
                          ),
                          //Building size part here
                          _buildSizePart(),
                          SizedBox(
                            height: 15,
                          ),
                          //Building color part here
                          _buildColorPart(),
                          SizedBox(
                            height: 15,
                          ),
                          //build quantity part here
                          _buildQuatityPart(),
                          SizedBox(
                            height: 15,
                          ),
                          //build  button part here
                          _buildButtonPart()
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

//building button part here
  Widget _buildButtonPart() {
    return Container(
      height: 60,
      width: double.infinity,
      // ignore: deprecated_member_use
      child: MyButton(
        onPressed: () {
          productProvider!.getCartData(
            image: widget.image,
            name: widget.name,
            price: widget.price,
            quantity: count,
          );
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (ctx) => CartScreen()));
        },
        name: "Check Out",
      ),
    );
  }

//Building Color Part Here
  Widget _buildColorPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Color",
          style: mystyle,
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          width: 265,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //build sized product
              _buildColorProduct(color: Colors.green[200]),
              _buildColorProduct(color: Colors.blue[200]),
              _buildColorProduct(color: Colors.yellow[200]),
              _buildColorProduct(color: Colors.cyan[200]),
            ],
          ),
        ),
      ],
    );
  }

//build quatity part here
  Widget _buildQuatityPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quantity",
          style: mystyle,
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          height: 40,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.blue[200],
            borderRadius: BorderRadius.circular(20),
          ),
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
    );
  }

//Building Size part here
  Widget _buildSizePart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Size",
          style: mystyle,
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          width: 265,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //build sized product
              _buildSizedProduct(name: 'S'),
              _buildSizedProduct(name: 'M'),
              _buildSizedProduct(name: 'L'),
              _buildSizedProduct(name: 'XL'),
            ],
          ),
        ),
      ],
    );
  }

  //building description part here
  Widget _buildDescription() {
    return Container(
      height: 140,
      //  color: Colors.blue,
      child: Wrap(
        children: [
          Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
            style: TextStyle(fontSize: 15),
          )
        ],
      ),
    );
  }

  //building Name to description part here
  Widget _buildNametoDescriptionPart() {
    return Container(
      height: 100,
      //color: Colors.blue,
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.name}",
                style: mystyle,
              ),
              Text(
                "Rs ${widget.price.toString()}",
                style: TextStyle(
                  color: Color(0xff9b96d6),
                  fontSize: 18,
                ),
              ),
              Text(
                "Description",
                style: mystyle,
              )
            ],
          ),
        ],
      ),
    );
  }

// Building Image
  Widget _buildImage() {
    return Center(
        child: Container(
            width: 350,
            child: Card(
              child: Container(
                padding: EdgeInsets.all(13),
                child: Container(
                  height: 220,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      //fit: BoxFit.fill,
                      image: NetworkImage(widget.image),
                    ),
                  ),
                ),
              ),
            )));
  }
}
