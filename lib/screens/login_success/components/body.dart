import 'package:e_commerce_app/components/default_button.dart';
import 'package:e_commerce_app/services/authentication_service.dart';
import 'package:e_commerce_app/size_config.dart';
import 'package:e_commerce_app/screens/home_page/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User user = context.watch<AuthenticationService>().getCurrUser();
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Image.asset(
                  "assets/images/success.png",
                  height: SizeConfig.screenHeight * 0.5,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Text(
                  "Hello ${user.email}",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(20),
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                SizedBox(
                  width: SizeConfig.screenWidth * 0.6,
                  child: DefaultButton(
                    text: "Back to home",
                    handleOnPress: () {
                      Navigator.pushNamed(context, HomeScreen.routeName);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
