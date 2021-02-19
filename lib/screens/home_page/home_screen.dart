import 'package:e_commerce_app/components/custom_bottom_nav.dart';
import 'package:e_commerce_app/constants.dart';

import 'package:e_commerce_app/screens/home_page/components/body.dart';
import 'package:flutter/material.dart';

import 'components/app_bar.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: CustomBottomNav(selectedMenu: MenuState.home),
    );
  }
}
