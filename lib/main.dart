// @dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:specswear_ecom/provider/category_provider.dart';
import 'package:specswear_ecom/provider/product_provider.dart';
import 'package:specswear_ecom/screens/homepage.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CategoryProvider>(create: (ctx) => CategoryProvider()),
        Provider<ProductProvider>(create: (ctx) => ProductProvider())
      ],
      child: MaterialApp(
        title: 'Specs Wear',
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (ctx, snapshot) {
              if (snapshot.hasData) {
                return HomePage();
              } else {
                return HomePage(); // later replace homePage with login
              }
            }),
      ),
    );
  }
}
