// ignore: import_of_legacy_library_into_null_safe
import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:specswear_ecom/model/categoryicon.dart';
import 'package:specswear_ecom/model/product.dart';
import 'package:specswear_ecom/provider/category_provider.dart';
import 'package:specswear_ecom/provider/product_provider.dart';
import 'package:specswear_ecom/screens/detailscreen.dart';
import 'package:specswear_ecom/screens/listproduct.dart';
import 'package:specswear_ecom/widgets/singleproduct.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

CategoryProvider? categoryProvider;
ProductProvider? productProvider;

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
  List<Product>? featuredSnapShot;
  List<Product>? archieveSnapShot;
  var menCatSnapShot;
  var womenCatSnapShot;
  var kidsCat;

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  Widget _buildcategoryProduct({required String image, required int color}) {
    return CircleAvatar(
      maxRadius: 38,
      backgroundColor: Color(color),
      child: Container(
          height: 60,
          width: 60,
          child: Center(
            child: Image(color: Colors.white, image: NetworkImage(image)),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    //getting data catagory wise with provider

    categoryProvider = Provider.of<CategoryProvider>(context);
    categoryProvider!.getMenData();
    categoryProvider!.getWomenData();
    categoryProvider!.getKidsData();
    categoryProvider!.getMenIconData();
    categoryProvider!.getWomenIconData();
    categoryProvider!.getKidsIconData();

//
//getting data product wise with provider
    productProvider = Provider.of<ProductProvider>(context);
    productProvider!.getFeaturedata();
    productProvider!.getArchievedata();
    productProvider!.getHomeFeaturedata();
    productProvider!.getHomeArchievedata();

//
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
      body: Container(
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
                  //continue from here after break
                  //Build Featured product
                  _buildFeatured(),
                  // New Archieve product
                  _buildNewArchieve(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

//Build New Archive Section
  Widget _buildNewArchieve() {
    List<Product?> archieveProduct = productProvider!.getArchieveDataList;
    List<Product?> homeArchieveProduct =
        productProvider!.getHomeArchieveDataList;

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
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => ListProduct(
                            name: "New Arrival",
                            snapShot: archieveProduct,
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
          children: homeArchieveProduct.map((e) {
            return Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => DetailScreen(
                                image: "${e?.image}",
                                name: "${e?.name}",
                                price: e?.price!.toDouble()),
                          ),
                        );
                      },
                      child: SingleProduct(
                        name: "${e?.name}",
                        price: e?.price!.toDouble(),
                        image: "${e?.image}",
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => DetailScreen(
                            image: "${e?.image}",
                            name: "${e?.name}",
                            price: e?.price!.toDouble(),
                          ),
                        ),
                      );
                    },
                    child: SingleProduct(
                        name: "${e?.name}",
                        price: e?.price!.toDouble(),
                        image: "${e?.image}"),
                  )
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

// Build Featured Product section
  Widget _buildFeatured() {
    List<Product?> featureProduct = productProvider!.getFeatureDataList;
    List<Product?> homeFeatureProduct = productProvider!.getHomeFeatureDataList;

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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext ctx) => ListProduct(
                      name: "Featured",
                      snapShot: featureProduct,
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
            children: homeFeatureProduct.map((e) {
          return Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => DetailScreen(
                            image: "${e?.image}",
                            name: "${e?.name}",
                            price: e?.price!.toDouble(),
                          ),
                        ),
                      );
                    },
                    child: SingleProduct(
                        name: "${e?.name}",
                        price: e?.price!.toDouble(),
                        image: "${e?.image}"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => DetailScreen(
                          image: "${e?.image}",
                          name: "${e?.name}",
                          price: e?.price!.toDouble(),
                        ),
                      ),
                    );
                  },
                  child: SingleProduct(
                      name: "${e?.name}",
                      price: e?.price!.toDouble(),
                      image: "${e?.image}"),
                )
              ],
            ),
          );
        }).toList()),
      ],
    );
  }

//build Catory Section widget
  Widget _buildCategory() {
    List<Product?> women = categoryProvider!.getWomenDataList;
    List<Product?> kids = categoryProvider!.getKidsDataList;

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
              _buildMenIcon(),
              _buildWomenIcon(),
              _buildKidsIcon(),
            ],
          ),
        ),
      ],
    );
  }
//building women icon here

  Widget _buildKidsIcon() {
    List<CategoryIcon?> kidsIcon = categoryProvider!.getKidsIconDataList;
    List<Product?> kids = categoryProvider!.getKidsDataList;
    return Row(
        children: kidsIcon.map((e) {
      return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => ListProduct(
                  name: 'Kids',
                  snapShot: kids,
                ),
              ),
            );
          },
          child:
              _buildcategoryProduct(image: '${e?.image}', color: 0xff4ff2af));
    }).toList());
  }
//building women icon here

  Widget _buildWomenIcon() {
    List<CategoryIcon?> womenIcon = categoryProvider!.getWomenIconDataList;
    List<Product?> women = categoryProvider!.getWomenDataList;
    return Row(
        children: womenIcon.map((e) {
      return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => ListProduct(
                  name: 'Women',
                  snapShot: women,
                ),
              ),
            );
          },
          child:
              _buildcategoryProduct(image: '${e?.image}', color: 0xfff38cdd));
    }).toList());
  }

//building men icon here
  Widget _buildMenIcon() {
    List<CategoryIcon?> menIcon = categoryProvider!.getMenIconDataList;
    List<Product?> men = categoryProvider!.getMenDataList;

    return Row(
        children: menIcon.map((e) {
      return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => ListProduct(
                  name: 'Men',
                  //add mapping here

                  snapShot: men,
                ),
              ),
            );
          },
          child:
              _buildcategoryProduct(image: "${e?.image}", color: 0xff33dcfd));
    }).toList());
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
