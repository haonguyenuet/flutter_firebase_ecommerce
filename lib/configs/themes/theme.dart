import 'package:e_commerce_app/configs/themes/text_theme.dart';
import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:flutter/material.dart';

import 'appbar_theme.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Poppins",
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: mPrimaryColor),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
