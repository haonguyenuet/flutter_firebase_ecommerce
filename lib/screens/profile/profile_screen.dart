import 'package:e_commerce_app/components/custom_bottom_nav.dart';
import 'package:e_commerce_app/screens/profile/components/body.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

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
