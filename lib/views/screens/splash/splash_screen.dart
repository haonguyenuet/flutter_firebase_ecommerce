import 'package:e_commerce_app/views/widgets/others/logo.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/configs/size_config.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Logo(),
              SizedBox(height: SizeConfig.defaultSize), // 10
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
