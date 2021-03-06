import 'package:e_commerce_app/configs/themes/text_theme.dart';
import 'package:flutter/material.dart';

import 'appbar_theme.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Poppins",
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
