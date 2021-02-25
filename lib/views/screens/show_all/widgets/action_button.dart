import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:e_commerce_app/constants/color_constant.dart';

class ActionButton extends StatelessWidget {
  final String iconPath;
  final String name;
  final Function handleOnTap;

  const ActionButton({
    Key key,
    this.iconPath,
    this.name,
    this.handleOnTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: handleOnTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconPath,
            color: mPrimaryColor,
          ),
          const SizedBox(width: 10),
          Text(
            name,
            style: TextStyle(color: mPrimaryColor, fontSize: 16),
          )
        ],
      ),
    );
  }
}
