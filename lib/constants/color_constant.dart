import 'package:flutter/material.dart';

class COLOR_CONST {
  static const primaryColor = Color(0xFF3ac5c9);
  static const accentTintColor = Color(0xFF7b60c4);
  static const accentShadeColor = Color(0xFF58458c);
  static const darkShadeColor = Color(0xFF25164d);
  static const borderColor = Color(0xFFd3d1d1);
  static const backgroundColor = Color(0xffF6F7FB);
  static const cardShadowColor = Color(0xFFd3d1d1);
  static const dividerColor = Colors.black12;
  static const primaryGradientColor = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF25164d), Colors.white],
  );

  static const secondaryColor = Color(0xFF979797);
  static const textColor = Color(0xFF4a4a4a);
  static const googleButtonColor = Color(0xFFFFF1F0);
  static const deleteButtonColor = Color(0xFFeb4d4b);
  static const googleButtonColorBorder = Color(0xFFF14336);
  static const facebookButtonColor = Color(0xFFF5F9FF);
  static const facebookButtonColorBorder = Color(0xFF3164CE);
  static const discountColor = Color(0xFFF17322);

  ///Singleton factory
  static final COLOR_CONST _instance = COLOR_CONST._internal();

  factory COLOR_CONST() {
    return _instance;
  }

  COLOR_CONST._internal();
}

const mAnimationDuration = Duration(milliseconds: 200);
