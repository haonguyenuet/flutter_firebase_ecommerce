import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/color_constant.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/icons/keyboard_logo.svg",
                width: 100,
                height: 100,
              ),
              Text(
                "Peachy",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(36),
                  color: mPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              SpinKitChasingDots(color: mPrimaryColor),
            ],
          ),
        ),
      ),
    );
  }
}
