import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';

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
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 10,
        children: [
          SvgPicture.asset(
            iconPath,
            color: mPrimaryColor,
          ),
          Text(
            name,
            style: TextStyle(color: mPrimaryColor, fontSize: 16),
          )
        ],
      ),
    );
  }
}
