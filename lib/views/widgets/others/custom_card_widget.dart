import 'package:e_commerce_app/constants/constants.dart';
import 'package:flutter/material.dart';

class CustomCardWidget extends StatelessWidget {
  final Widget child;
  final BoxDecoration? decoration;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Function()? onTap;

  const CustomCardWidget({
    Key? key,
    this.decoration,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: width,
          height: height,
          margin: margin,
          padding: padding,
          decoration: decoration ?? _getDefaultDecoration(),
          child: child,
        ),
      ),
    );
  }

  _getDefaultDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: mBorderColor.withOpacity(0.3)),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          blurRadius: 1,
          spreadRadius: 1,
          color: mCardShadowColor.withOpacity(0.2),
          offset: Offset(0, 2),
        ),
      ],
    );
  }
}
