import 'package:e_commerce_app/configs/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/icons/logo.svg",
      width: SizeConfig.defaultSize * 10,
      height: SizeConfig.defaultSize * 10,
    );
  }
}
