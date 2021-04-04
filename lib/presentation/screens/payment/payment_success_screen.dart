import 'package:e_commerce_app/configs/config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:flutter/material.dart';

class PaymentSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Image.asset(IMAGE_CONST.SUCCESS),
            SizedBox(height: SizeConfig.defaultSize),
            Text(
              "Payment success",
              style: FONT_CONST.BOLD_DEFAULT_20,
            )
          ],
        ),
      ),
    );
  }
}
