import 'package:flutter/material.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/color_constant.dart';

class DefaultButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget child;

  const DefaultButton({
    Key? key,
    this.onPressed,
    required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: SizeConfig.defaultSize * 5,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(backgroundColor: mPrimaryColor),
        child: child,
      ),
    );
  }
}
