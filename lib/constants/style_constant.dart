import 'package:e_commerce_app/configs/size_config.dart';
import 'package:flutter/material.dart';

import 'color_constant.dart';

/// Style
OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide(color: mTextColor),
  );
}

TextStyle headingStyle() {
  return TextStyle(
    color: Colors.black,
    fontSize: getProportionateScreenWidth(28),
    fontWeight: FontWeight.bold,
  );
}

enum MenuState { home, profile }
