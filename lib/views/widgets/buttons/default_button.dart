import 'package:flutter/material.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/color_constant.dart';

class DefaultButton extends StatelessWidget {
  final Function? onPressed;
  final Widget? child;

  const DefaultButton({
    Key? key,
    this.onPressed,
    this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        width: double.infinity,
        height: getProportionateScreenHeight(50),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 5),
              blurRadius: 10,
              color: mPrimaryColor.withOpacity(0.3),
            ),
          ],
        ),
        child: TextButton(
          onPressed: onPressed as void Function()?,
          style: TextButton.styleFrom(backgroundColor: mPrimaryColor),
          child: child!,
        ),
      ),
    );
  }
}
