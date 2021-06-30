import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:provider/provider.dart';
import 'package:specswear_ecom/provider/product_provider.dart';

class NotificationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    return Badge(
      position: BadgePosition(top: 8, start: 25),
      badgeContent: Text(
        productProvider.getNotificationIndex.toString(),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      badgeColor: Colors.red,
      child: IconButton(
        color: Colors.black,
        onPressed: () {},
        icon: Icon(
          Icons.notifications_none,
        ),
      ),
    );
  }
}
