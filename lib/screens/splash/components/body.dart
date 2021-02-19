import 'dart:async';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/screens/authentication/authentication_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../size_config.dart';

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 4),
      () => Navigator.pushNamedAndRemoveUntil(
        context,
        AuthenticationWrapper.routeName,
        (_) => false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
            Text(
              "Just stay at home and click",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            SvgPicture.asset("assets/icons/peach.svg"),
            SizedBox(height: 10),
            SpinKitChasingDots(color: mPrimaryColor),
          ],
        ),
      ),
    );
  }
}
