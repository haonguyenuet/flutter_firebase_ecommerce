import 'package:e_commerce_app/configs/config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:flutter/material.dart';

class PaymentButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final Color? buttonColor;

  const PaymentButton({
    Key? key,
    this.onPressed,
    required this.text,
    this.buttonColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeConfig.defaultSize * 3),
          color: buttonColor,
        ),
        padding: EdgeInsets.all(SizeConfig.defaultSize * 2),
        child: Text(
          text,
          style: FONT_CONST.BOLD_WHITE_18,
        ),
      ),
    );
  }
}
