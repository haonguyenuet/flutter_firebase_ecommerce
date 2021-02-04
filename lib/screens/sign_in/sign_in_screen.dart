import 'package:e_commerce_app/screens/sign_in/components/body.dart';
import 'package:e_commerce_app/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/signIn";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
            context,
            SplashScreen.routeName,
            (_) => false,
          ),
        ),
        title: Text("Sign In"),
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}
