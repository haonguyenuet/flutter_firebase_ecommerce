import 'dart:async';
import 'package:e_commerce_app/components/loading_screen.dart';
import 'package:e_commerce_app/screens/authentication/authentication_screen.dart';
import 'package:flutter/material.dart';

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
    return LoadingScreen();
  }
}
