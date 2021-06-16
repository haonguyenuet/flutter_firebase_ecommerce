import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Slogan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.defaultSize,
        horizontal: SizeConfig.defaultPadding,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.black12, width: 1),
          bottom: BorderSide(color: Colors.black12, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildSloganItem(
            iconPath: "assets/icons/return-free.svg",
            text: "Free return",
          ),
          _buildSloganItem(
            iconPath: "assets/icons/safety.svg",
            text: "Authentic 100%",
          ),
          _buildSloganItem(
            iconPath: "assets/icons/shipping.svg",
            text: "Fast delivery",
          ),
        ],
      ),
    );
  }

  _buildSloganItem({required String iconPath, required String text}) {
    return Row(
      children: [
        SvgPicture.asset(
          iconPath,
          width: SizeConfig.defaultSize * 3,
          height: SizeConfig.defaultSize * 3,
          color: COLOR_CONST.primaryColor,
        ),
        SizedBox(width: SizeConfig.defaultSize * 0.5),
        Text(text, style: FONT_CONST.REGULAR_DEFAULT_18),
      ],
    );
  }
}
