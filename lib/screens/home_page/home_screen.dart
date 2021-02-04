import 'package:e_commerce_app/components/custom_bottom_nav.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/screens/home_page/components/body.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      bottomNavigationBar: CustomerBottomNav(selectedMenu: MenuState.home),
    );
  }
}
