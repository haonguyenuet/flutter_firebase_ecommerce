import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/presentation/widgets/others/logo.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/configs/size_config.dart';

class InitializeInfoHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.04),
        Logo(),
        Text(
          "Complete Information",
          style: FONT_CONST.BOLD_WHITE_26,
        ),
        Text(
          "It's so quick and easy",
          style: FONT_CONST.REGULAR_WHITE,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.04),
      ],
    );
  }
}
