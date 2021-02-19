import 'package:e_commerce_app/screens/sign_in/components/sign_in_form.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'no_account_text.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Text(
                "Welcome Back",
                style: headingStyle(),
              ),
              Text(
                "Sign in with your email and password\n or continue with social media",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              SignInForm(),
              SizedBox(height: SizeConfig.screenHeight * 0.01),
              NoAccountText(),
            ],
          ),
        ),
      ),
    );
  }
}
