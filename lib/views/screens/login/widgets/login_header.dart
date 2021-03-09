import 'package:e_commerce_app/constants/font_constant.dart';
import 'package:e_commerce_app/views/widgets/others/logo.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/configs/size_config.dart';

class LoginHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight * 0.04),
      child: Column(
        children: [
          Logo(),
          Text(
            "Welcome Back",
            style: FONT_CONST.BOLD_WHITE_26,
          ),
          Text(
            "Sign in with your email and password\n or continue with social media",
            style: FONT_CONST.REGULAR_WHITE,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
