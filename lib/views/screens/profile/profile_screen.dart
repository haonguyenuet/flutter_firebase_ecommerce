import 'package:e_commerce_app/constants/style_constant.dart';
import 'package:e_commerce_app/views/widgets/custom_bottom_nav.dart';
import 'package:e_commerce_app/views/screens/profile/widgets/body.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNav(selectedMenu: MenuState.profile),
    );
  }
}
