import 'package:e_commerce_app/screens/login_success/login_success_screen.dart';
import 'package:e_commerce_app/screens/sign_in/sign_in_screen.dart';
import 'package:e_commerce_app/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthenticaitonWrapper extends StatelessWidget {
  static String routeName = "/authentication";
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: context.watch<AuthenticationService>().user,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return snapshot.data != null ? LoginSuccessScreen() : SignInScreen();
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
