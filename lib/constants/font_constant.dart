import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:flutter/material.dart';

class FONT_CONST {
  static final REGULAR = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    color: Colors.black,
    fontSize: SizeConfig.defaultSize * 1.4,
  );

  static final MEDIUM = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
    color: Colors.black,
    fontSize: SizeConfig.defaultSize * 1.4,
  );

  static final BOLD = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w600,
    color: Colors.black,
    fontSize: SizeConfig.defaultSize * 1.4,
  );

  //REGULAR
  static final REGULAR_DEFAULT = REGULAR.copyWith(color: COLOR_CONST.textColor);
  static final REGULAR_DEFAULT_16 =
      REGULAR_DEFAULT.copyWith(fontSize: SizeConfig.defaultSize * 1.6);
  static final REGULAR_DEFAULT_18 =
      REGULAR_DEFAULT.copyWith(fontSize: SizeConfig.defaultSize * 1.8);
  static final REGULAR_DEFAULT_20 =
      REGULAR_DEFAULT.copyWith(fontSize: SizeConfig.defaultSize * 2);

  static final REGULAR_PRIMARY =
      REGULAR.copyWith(color: COLOR_CONST.primaryColor);
  static final REGULAR_PRIMARY_16 =
      REGULAR_PRIMARY.copyWith(fontSize: SizeConfig.defaultSize * 1.6);
  static final REGULAR_PRIMARY_18 =
      REGULAR_PRIMARY.copyWith(fontSize: SizeConfig.defaultSize * 1.8);
  static final REGULAR_PRIMARY_20 =
      REGULAR_PRIMARY.copyWith(fontSize: SizeConfig.defaultSize * 2);

  static final REGULAR_WHITE = REGULAR.copyWith(color: Colors.white);
  static final REGULAR_WHITE_16 =
      REGULAR_WHITE.copyWith(fontSize: SizeConfig.defaultSize * 1.6);
  static final REGULAR_WHITE_18 =
      REGULAR_WHITE.copyWith(fontSize: SizeConfig.defaultSize * 1.8);
  static final REGULAR_WHITE_20 =
      REGULAR_WHITE.copyWith(fontSize: SizeConfig.defaultSize * 2);

  //MEDIUM (SEMIBOLD)
  static final MEDIUM_DEFAULT = MEDIUM.copyWith(color: COLOR_CONST.textColor);
  static final MEDIUM_DEFAULT_16 =
      MEDIUM_DEFAULT.copyWith(fontSize: SizeConfig.defaultSize * 1.6);
  static final MEDIUM_DEFAULT_18 =
      MEDIUM_DEFAULT.copyWith(fontSize: SizeConfig.defaultSize * 1.8);
  static final MEDIUM_DEFAULT_20 =
      MEDIUM_DEFAULT.copyWith(fontSize: SizeConfig.defaultSize * 2);

  static final MEDIUM_PRIMARY =
      MEDIUM.copyWith(color: COLOR_CONST.primaryColor);
  static final MEDIUM_PRIMARY_16 =
      MEDIUM_PRIMARY.copyWith(fontSize: SizeConfig.defaultSize * 1.6);
  static final MEDIUM_PRIMARY_18 =
      MEDIUM_PRIMARY.copyWith(fontSize: SizeConfig.defaultSize * 1.8);
  static final MEDIUM_PRIMARY_20 =
      MEDIUM_PRIMARY.copyWith(fontSize: SizeConfig.defaultSize * 2);
  static final MEDIUM_PRIMARY_24 =
      MEDIUM_PRIMARY.copyWith(fontSize: SizeConfig.defaultSize * 2.4);

  static final MEDIUM_WHITE = MEDIUM.copyWith(color: Colors.white);
  static final MEDIUM_WHITE_16 =
      MEDIUM_WHITE.copyWith(fontSize: SizeConfig.defaultSize * 1.6);
  static final MEDIUM_WHITE_18 =
      MEDIUM_WHITE.copyWith(fontSize: SizeConfig.defaultSize * 1.8);
  static final MEDIUM_WHITE_20 =
      MEDIUM_WHITE.copyWith(fontSize: SizeConfig.defaultSize * 2);

  //BOLD
  static final BOLD_DEFAULT = BOLD.copyWith(color: COLOR_CONST.textColor);
  static final BOLD_DEFAULT_16 =
      BOLD_DEFAULT.copyWith(fontSize: SizeConfig.defaultSize * 1.6);
  static final BOLD_DEFAULT_18 =
      BOLD_DEFAULT.copyWith(fontSize: SizeConfig.defaultSize * 1.8);
  static final BOLD_DEFAULT_20 =
      BOLD_DEFAULT.copyWith(fontSize: SizeConfig.defaultSize * 2);
  static final BOLD_DEFAULT_24 =
      BOLD_DEFAULT.copyWith(fontSize: SizeConfig.defaultSize * 2.4);
  static final BOLD_DEFAULT_26 =
      BOLD_DEFAULT.copyWith(fontSize: SizeConfig.defaultSize * 2.6);

  static final BOLD_PRIMARY = BOLD.copyWith(color: COLOR_CONST.primaryColor);
  static final BOLD_PRIMARY_16 =
      BOLD_PRIMARY.copyWith(fontSize: SizeConfig.defaultSize * 1.6);
  static final BOLD_PRIMARY_18 =
      BOLD_PRIMARY.copyWith(fontSize: SizeConfig.defaultSize * 1.8);
  static final BOLD_PRIMARY_20 =
      BOLD_PRIMARY.copyWith(fontSize: SizeConfig.defaultSize * 2);
  static final BOLD_PRIMARY_24 =
      BOLD_PRIMARY.copyWith(fontSize: SizeConfig.defaultSize * 2.4);
  static final BOLD_PRIMARY_26 =
      BOLD_PRIMARY.copyWith(fontSize: SizeConfig.defaultSize * 2.6);

  static final BOLD_WHITE = BOLD.copyWith(color: Colors.white);
  static final BOLD_WHITE_16 =
      BOLD_WHITE.copyWith(fontSize: SizeConfig.defaultSize * 1.6);
  static final BOLD_WHITE_18 =
      BOLD_WHITE.copyWith(fontSize: SizeConfig.defaultSize * 1.8);
  static final BOLD_WHITE_20 =
      BOLD_WHITE.copyWith(fontSize: SizeConfig.defaultSize * 2);
  static final BOLD_WHITE_26 =
      BOLD_WHITE.copyWith(fontSize: SizeConfig.defaultSize * 2.6);
  static final BOLD_WHITE_32 =
      BOLD_WHITE.copyWith(fontSize: SizeConfig.defaultSize * 3.2);

  ///Singleton factory
  static final FONT_CONST _instance = FONT_CONST._internal();

  factory FONT_CONST() {
    return _instance;
  }

  FONT_CONST._internal();
}
