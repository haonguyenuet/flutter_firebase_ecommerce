import 'package:e_commerce_app/constants/style_constant.dart';
import 'package:e_commerce_app/views/widgets/custom_bottom_nav.dart';

import 'package:e_commerce_app/views/screens/home_page/widgets/body.dart';
import 'package:flutter/material.dart';

import 'widgets/app_bar.dart';

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
