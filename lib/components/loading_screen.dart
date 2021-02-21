import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';
import '../size_config.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Peachy",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(36),
                  color: mPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              SvgPicture.asset("assets/icons/peach.svg"),
              SizedBox(height: 10),
              SpinKitChasingDots(color: mPrimaryColor),
            ],
          ),
        ),
      ),
    );
  }
}
