import 'package:e_commerce_app/providers/authentication_provider.dart';
import 'package:e_commerce_app/providers/cart_provider.dart';
import 'package:e_commerce_app/screens/login_success/login_success_screen.dart';
import 'package:e_commerce_app/screens/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthenticationWrapper extends StatelessWidget {
  static String routeName = "/authentication";
  @override
  Widget build(BuildContext context) {
    var auth = context.watch<AuthenticationProvider>();
    var cart = context.watch<CartProvider>();
    switch (auth.status) {
      case Status.Authenticated:
        cart.setId(auth.user.uid);
        return LoginSuccessScreen();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return SignInScreen();
      default:
        return SignInScreen();
    }
  }
}
