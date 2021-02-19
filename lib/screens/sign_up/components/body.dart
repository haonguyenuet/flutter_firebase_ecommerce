import 'package:e_commerce_app/screens/sign_in/sign_in_screen.dart';
import 'package:e_commerce_app/screens/sign_up/components/sign_up_form.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: SizeConfig.screenHeight * 0.04),
            Text(
              "Register Account",
              style: headingStyle(),
            ),
            Text(
              "It's so quick and easy",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.04),
            SignUpForm(),
            SizedBox(height: SizeConfig.screenHeight * 0.04),
            AvailableAccount(),
          ],
        ),
      ),
    ));
  }
}

class AvailableAccount extends StatelessWidget {
  const AvailableAccount({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Already have an account."),
        SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
                context, SignInScreen.routeName, (_) => false);
          },
          child: Text(
            "Sign in",
            style: TextStyle(
              color: mPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
