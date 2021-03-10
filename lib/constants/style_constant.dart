import 'package:e_commerce_app/constants/constants.dart';
import 'package:flutter/material.dart';

enum MenuState { home, profile }

const double mDefaultPadding = 15;
const double mDefaultMargin = 15;

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide(color: mTextColor),
  );
}
