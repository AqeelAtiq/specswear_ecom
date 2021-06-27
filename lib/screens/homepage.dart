import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:specswear_ecom/provider/category_provider.dart';
import 'package:specswear_ecom/screens/detailscreen.dart';
import 'package:specswear_ecom/screens/listproduct.dart';
import 'package:specswear_ecom/widgets/singleproduct.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:specswear_ecom/model/product.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

CategoryProvider? provider;
Product? menData;
Product? womenData;
Product? archMenData;
Product? archWomenData;
Product? archKidData;

class _HomePageState extends State<HomePage> {
  bool homeColor = true;
  bool cartColor = false;
  bool aboutColor = false;
  bool contactusColor = false;
  var featuredSnapShot;
  var archieveSnapShot;
  var menCat;
  var womenCat;
  var kidCat;

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  Widget _buildcategoryProduct({required String name, required int color}) {
    return CircleAvatar(
      maxRadius: 38,
      backgroundColor: Color(color),
      child: Container(
          height: 50,
          width: 50,
          child: Text(
            "$name",
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<CategoryProvider>(context);
    provider!.getMenData();
    return Scaffold(
      key: _key,
      drawer: _buildMyDrawer(),
      appBar: AppBar(
        title: Text(
          "Home Page",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.grey[100],
        leading: IconButton(
          icon: Icon(Icons.menu),
          color: Colors.black,
          onPressed: () {
            _key.currentState?.openDrawer();
          },
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.send,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection("products")
              .doc("npOtqxmDUdXcGsgxDgsN")
              .collection("featureproduct")
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            featuredSnapShot = snapshot;
            menData = Product(
              image: snapshot.data!.docs[0]['image'],
              name: snapshot.data!.docs[0]['name'],
              price: snapshot.data!.docs[0]['price'].toDouble(),
            );
            womenData = Product(
              image: snapshot.data!.docs[1]['image'],
              name: snapshot.data!.docs[1]['name'],
              price: snapshot.data!.docs[1]['price'].toDouble(),
            );
            print(snapshot.data!.docs[3]['name']);
            // print(snapshot.data!.docs[0]['price'].toDouble());
            //print(womenData?.price);
            return FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection("category")
                    .doc("y5NuMWFTeQiIkIHmRA9D")
                    .collection("men")
                    .get(),
                builder: (context, menSnapShot) {
                  if (menSnapShot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  // there is probelem with getting data solve it later video 15 13:00 min
                  menCat = snapshot;
                  print("printing at index 1");
                  print(snapshot.data!.docs[0]['name']);

                  return FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection("products")
                          .doc("npOtqxmDUdXcGsgxDgsN")
                          .collection("newarchieve")
                          .get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot?> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        archieveSnapShot = snapshot;
                        archMenData = Product(
                          image: snapshot.data!.docs[0]['image'],
                          name: snapshot.data!.docs[0]['name'],
                          price: snapshot.data!.docs[0]['price'].toDouble(),
                        );
                        archKidData = Product(
                          image: snapshot.data!.docs[1]['image'],
                          name: snapshot.data!.docs[1]['name'],
                          price: snapshot.data!.docs[1]['price'].toDouble(),
                        );
                        return Container(
                          height: double.infinity,
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: ListView(
                            children: [
                              Container(
                                width: double.infinity,
                                // color: Colors.blue,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildImageSlider(),
                                    //build Categiry
                                    _buildCategory(),

//
                                    SizedBox(
                                      height: 20,
                                    ),
                                    //Build Featured product
                                    _buildFeatured(),
                                    // New Archieve product
                                    _buildNewArchieve(),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      });
                });
          }),
    );
  }

//Build New Archive Section
  Widget _buildNewArchieve() {
    return Column(
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
                    "New Archieve",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => ListProduct(
                            name: "New Archieve",
                            snapShot: archieveSnapShot,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "View More",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (ctx) => DetailScreen(
                                image: "${archMenData?.image}",
                                name: "${archMenData?.name}",
                                price: archMenData!.price),
                          ),
                        );
                      },
                      child: SingleProduct(
                          name: "${archMenData?.name}",
                          price: archMenData!.price,
                          image: "${archMenData?.image}"),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (ctx) => DetailScreen(
                                image: "${archKidData?.image}",
                                name: "${archKidData?.name}",
                                price: archKidData!.price),
                          ),
                        );
                      },
                      child: SingleProduct(
                          name: "${archKidData?.name}",
                          price: archKidData!.price,
                          image: "${archKidData?.image}"),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ],
    );
  }

// Build Featured Product section
  Widget _buildFeatured() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Featured",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => ListProduct(
                      name: "Featured",
                      snapShot: featuredSnapShot,
                    ),
                  ),
                );
              },
              child: Text(
                "View More",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => DetailScreen(
                        image: "${menData?.image}",
                        name: "${menData?.name}",
                        price: menData!.price),
                  ),
                );
              },
              child: SingleProduct(
                  name: "${menData?.name}",
                  price: menData!.price,
                  image: "${menData?.image}"),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => DetailScreen(
                        image: "${womenData?.image}",
                        name: "${womenData?.name}",
                        price: womenData!.price),
                  ),
                );
              },
              child: SingleProduct(
                  name: "${womenData?.name}",
                  price: womenData!.price,
                  image: "${womenData?.image}"),
            )
          ],
        ),
      ],
    );
  }

//build Catory Section widget
  Widget _buildCategory() {
    return Column(
      children: [
        Container(
          height: 50,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // category part
              Text(
                "Categories",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
          height: 60,
          child: Row(
            children: [
              //set image size later
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (ctx) => ListProduct(
                          name: 'Men',
                          snapShot: menCat,
                        ),
                      ),
                    );
                  },
                  child: _buildcategoryProduct(name: 'Men', color: 0xff33dcfd)),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (ctx) => ListProduct(
                          name: 'Wonen',
                          snapShot: menCat,
                        ),
                      ),
                    );
                  },
                  child:
                      _buildcategoryProduct(name: 'Women', color: 0xfff38cdd)),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (ctx) => ListProduct(
                          name: 'Kids',
                          snapShot: menCat,
                        ),
                      ),
                    );
                  },
                  child:
                      _buildcategoryProduct(name: 'Kids', color: 0xff4ff2af)),
            ],
          ),
        ),
      ],
    );
  }

//image slider
  Widget _buildImageSlider() {
    return Container(
      height: 240,
      padding: EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Carousel(
        dotColor: Colors.white,
        autoplay: true,
        showIndicator: false,
        dotBgColor: Colors.pinkAccent,
        images: [
          AssetImage(
            "images/k1.webp",
          ),
          AssetImage("images/k2.webp"),
          AssetImage("images/k3.webp"),
          AssetImage("images/k4.webp"),
        ],
      ),
    );
  }

// menu or drawer
  Widget _buildMyDrawer() {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("images/k1.webp"),
            ),
            accountName: Text(
              "Aqeel Atiq",
              style: TextStyle(color: Colors.black),
            ),
            accountEmail: Text(
              "aqeelatiq.arain@gmail.com",
              style: TextStyle(color: Colors.black),
            ),
            decoration: BoxDecoration(color: Color(0xfff2f2f2)),
          ),
          ListTile(
            selected: homeColor,
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {
              setState(() {
                homeColor = true;
                cartColor = false;
                aboutColor = false;
                contactusColor = false;
              });
            },
          ),
          ListTile(
            selected: cartColor,
            leading: Icon(Icons.shopping_cart),
            title: Text("Cart"),
            onTap: () {
              setState(() {
                homeColor = false;
                cartColor = true;
                aboutColor = false;
                contactusColor = false;
              });
            },
          ),
          ListTile(
            selected: aboutColor,
            leading: Icon(Icons.info),
            title: Text("About"),
            onTap: () {
              setState(() {
                homeColor = false;
                cartColor = false;
                aboutColor = true;
                contactusColor = false;
              });
            },
          ),
          ListTile(
            selected: contactusColor,
            leading: Icon(Icons.phone),
            title: Text("Contact Us"),
            onTap: () {
              setState(() {
                homeColor = false;
                cartColor = false;
                aboutColor = false;
                contactusColor = true;
              });
            },
          ),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
            leading: Icon(Icons.logout),
            title: Text("Log Out"),
          )
        ],
      ),
    );
  }
}
