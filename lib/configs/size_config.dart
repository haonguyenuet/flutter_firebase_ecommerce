import 'package:flutter/material.dart';

class SizeConfig {
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static Orientation? orientation;

  static double get defaultPadding => defaultSize * 1.5;

  void init(BoxConstraints constraints, Orientation orientation) {
    screenWidth = constraints.maxWidth;
    screenHeight = constraints.maxHeight;
    //Apple iPhone 11 viewport size is 414 x 896 (px)
    //With iPhone 11, i set defaultSize = 10;
    //So if the screen increase or decrease then our defaultSize also vary
    if (orientation == Orientation.portrait) {
      defaultSize = screenHeight * 10 / 896;
    } else {
      defaultSize = screenHeight * 10 / 414;
    }
  }

  ///Singleton factory
  static final SizeConfig _instance = SizeConfig._internal();

  factory SizeConfig() {
    return _instance;
  }

  SizeConfig._internal();
}
