import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static Orientation? orientation;

  void init(BoxConstraints constraints, Orientation orientation) {
    //Apple iPhone 11 viewport size is 414 x 896 (px)
    //With iPhone 11, i set defaultSize = 10;
    //So if the screen increase or decrease then our defaultSize also vary
    if (orientation == Orientation.portrait) {
      screenWidth = constraints.maxWidth;
      screenHeight = constraints.maxHeight;
      defaultSize = screenHeight * 10 / 896;
    } else {
      screenWidth = constraints.maxHeight;
      screenHeight = constraints.maxWidth;
      defaultSize = screenWidth * 10 / 414;
    }
  }
}
