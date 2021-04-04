import 'package:e_commerce_app/configs/config.dart';
import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData currentTheme = ThemeData(
    scaffoldBackgroundColor: COLOR_CONST.backgroundColor,
    fontFamily: "Roboto",
    appBarTheme: appBarTheme,
    textTheme: textTheme,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: COLOR_CONST.primaryColor,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final appBarTheme = AppBarTheme(
    color: Colors.white,
    shadowColor: COLOR_CONST.cardShadowColor,
    elevation: 0.4,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: COLOR_CONST.textColor),
    actionsIconTheme: IconThemeData(color: COLOR_CONST.textColor),
    centerTitle: true,
    textTheme: TextTheme(headline6: FONT_CONST.BOLD_DEFAULT_20),
  );

  static final textTheme = TextTheme(
      bodyText1: TextStyle(color: COLOR_CONST.textColor),
      bodyText2: TextStyle(color: COLOR_CONST.textColor));

  /// Singleton factory
  static final AppTheme _instance = AppTheme._internal();

  factory AppTheme() {
    return _instance;
  }

  AppTheme._internal();
}
