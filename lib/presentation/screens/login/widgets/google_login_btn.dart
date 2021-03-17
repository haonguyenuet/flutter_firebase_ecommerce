import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/color_constant.dart';

class GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: SizeConfig.defaultSize * 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: COLOR_CONST.googleButtonColor,
          border: Border.all(
            width: 0.8,
            color: COLOR_CONST.googleButtonColorBorder,
          ),
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: SvgPicture.asset(
                'assets/icons/ic_google.svg',
                width: SizeConfig.defaultSize * 2.4,
                height: SizeConfig.defaultSize * 2.4,
              ),
            ),
            Text("Google")
          ],
        ),
      ),
    );
  }
}
