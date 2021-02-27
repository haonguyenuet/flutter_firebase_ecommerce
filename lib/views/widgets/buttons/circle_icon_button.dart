import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CircleIconButton extends StatelessWidget {
  final double size;
  final Function onPressed;
  final String svgIcon;
  final Color color;

  const CircleIconButton({
    Key key,
    @required this.size,
    @required this.svgIcon,
    this.onPressed,
    this.color = mPrimaryLightColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          svgIcon,
          width: size,
          height: size,
        ),
      ),
    );
  }
}
