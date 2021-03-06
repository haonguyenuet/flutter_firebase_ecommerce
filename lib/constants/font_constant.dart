import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:flutter/material.dart';

class FONT_CONST {
  static final REGULAR = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    color: Colors.black,
    fontSize: 14,
  );

  static final MEDIUM = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
    color: Colors.black,
    fontSize: 14,
  );

  static final BOLD = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    color: Colors.black,
    fontSize: 14,
  );

  //REGULAR
  static final REGULAR_DEFAULT = REGULAR.copyWith(color: mTextColor);
  static final REGULAR_DEFAULT_16 = REGULAR_DEFAULT.copyWith(fontSize: 16);
  static final REGULAR_DEFAULT_18 = REGULAR_DEFAULT.copyWith(fontSize: 18);
  static final REGULAR_DEFAULT_20 = REGULAR_DEFAULT.copyWith(fontSize: 20);

  static final REGULAR_PRIMARY = REGULAR.copyWith(color: mPrimaryColor);
  static final REGULAR_PRIMARY_16 = REGULAR_PRIMARY.copyWith(fontSize: 16);
  static final REGULAR_PRIMARY_18 = REGULAR_PRIMARY.copyWith(fontSize: 18);
  static final REGULAR_PRIMARY_20 = REGULAR_PRIMARY.copyWith(fontSize: 20);

  static final REGULAR_WHITE = REGULAR.copyWith(color: Colors.white);
  static final REGULAR_WHITE_16 = REGULAR_WHITE.copyWith(fontSize: 16);
  static final REGULAR_WHITE_18 = REGULAR_WHITE.copyWith(fontSize: 18);
  static final REGULAR_WHITE_20 = REGULAR_WHITE.copyWith(fontSize: 20);
  static final REGULAR_WHITE_26 = REGULAR_WHITE.copyWith(fontSize: 26);

  //MEDIUM
  static final MEDIUM_DEFAULT = MEDIUM.copyWith(color: mTextColor);
  static final MEDIUM_DEFAULT_16 = MEDIUM_DEFAULT.copyWith(fontSize: 16);
  static final MEDIUM_DEFAULT_18 = MEDIUM_DEFAULT.copyWith(fontSize: 18);
  static final MEDIUM_DEFAULT_20 = MEDIUM_DEFAULT.copyWith(fontSize: 20);

  static final MEDIUM_PRIMARY = MEDIUM.copyWith(color: mPrimaryColor);
  static final MEDIUM_PRIMARY_16 = MEDIUM_PRIMARY.copyWith(fontSize: 16);
  static final MEDIUM_PRIMARY_18 = MEDIUM_PRIMARY.copyWith(fontSize: 18);
  static final MEDIUM_PRIMARY_20 = MEDIUM_PRIMARY.copyWith(fontSize: 20);
  static final MEDIUM_PRIMARY_24 = MEDIUM_PRIMARY.copyWith(fontSize: 24);

  static final MEDIUM_WHITE = MEDIUM.copyWith(color: Colors.white);
  static final MEDIUM_WHITE_16 = MEDIUM_WHITE.copyWith(fontSize: 16);
  static final MEDIUM_WHITE_18 = MEDIUM_WHITE.copyWith(fontSize: 18);
  static final MEDIUM_WHITE_20 = MEDIUM_WHITE.copyWith(fontSize: 20);
  static final MEDIUM_WHITE_26 = MEDIUM_WHITE.copyWith(fontSize: 26);

  //BOLD
  static final BOLD_DEFAULT = BOLD.copyWith(color: mTextColor);
  static final BOLD_DEFAULT_16 = BOLD_DEFAULT.copyWith(fontSize: 16);
  static final BOLD_DEFAULT_18 = BOLD_DEFAULT.copyWith(fontSize: 18);
  static final BOLD_DEFAULT_20 = BOLD_DEFAULT.copyWith(fontSize: 20);

  static final BOLD_PRIMARY = BOLD.copyWith(color: mPrimaryColor);
  static final BOLD_PRIMARY_16 = BOLD_PRIMARY.copyWith(fontSize: 16);
  static final BOLD_PRIMARY_18 = BOLD_PRIMARY.copyWith(fontSize: 18);
  static final BOLD_PRIMARY_20 = BOLD_PRIMARY.copyWith(fontSize: 20);

  static final BOLD_WHITE = BOLD.copyWith(color: Colors.white);
  static final BOLD_WHITE_16 = BOLD_WHITE.copyWith(fontSize: 16);
  static final BOLD_WHITE_18 = BOLD_WHITE.copyWith(fontSize: 18);
  static final BOLD_WHITE_20 = BOLD_WHITE.copyWith(fontSize: 20);
  static final BOLD_WHITE_26 = BOLD_WHITE.copyWith(fontSize: 26);
}
