import 'package:e_commerce_app/views/widgets/others/logo.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/style_constant.dart';

class LoginHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.04),
        Logo(),
        Text(
          "Welcome Back",
          style: headingStyle(),
        ),
        Text(
          "Sign in with your email and password\n or continue with social media",
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.04),
      ],
    );
  }
}
