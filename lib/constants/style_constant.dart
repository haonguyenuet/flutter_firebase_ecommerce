import 'package:e_commerce_app/constants/constants.dart';
import 'package:flutter/material.dart';

enum MenuState { home, profile }

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide(color: mTextColor),
  );
}
