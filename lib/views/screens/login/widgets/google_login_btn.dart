import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/color_constant.dart';

class GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: getProportionateScreenHeight(40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: googleButtonColor,
          border: Border.all(
            width: 0.8,
            color: googleButtonColorBorder,
          ),
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: SvgPicture.asset(
                'assets/icons/ic_google.svg',
                width: 24,
                height: 24,
              ),
            ),
            Text("Google")
          ],
        ),
      ),
    );
  }
}
