import 'package:e_commerce_app/presentation/screens/initialize_info/widgets/initialize_info_form.dart';
import 'package:e_commerce_app/presentation/screens/initialize_info/widgets/initialize_info_header.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/constants/color_constant.dart';

class InitializeInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR_CONST.accentShadeColor,
      body: Container(
        decoration: BoxDecoration(gradient: COLOR_CONST.primaryGradientColor),
        child: ListView(
          children: [
            InitializeInfoHeader(),
            InitializeInfoForm(),
          ],
        ),
      ),
    );
  }
}
