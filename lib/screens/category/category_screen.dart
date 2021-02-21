import 'package:e_commerce_app/screens/category/components/body.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  static String routeName = "/category";
  @override
  Widget build(BuildContext context) {
    // get arguments
    return Scaffold(
      backgroundColor: Colors.white,
      body: Body(),
    );
  }
}
