import 'package:e_commerce_app/size_config.dart';
import 'package:flutter/material.dart';

/// Colors
const mPrimaryColor = Color(0xFFFF7643);
const mPrimaryLightColor = Color(0xFFFFECDF);
const mPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const mSecondaryColor = Color(0xFF979797);
const mTextColor = Color(0xFF757575);

const mAnimationDuration = Duration(milliseconds: 200);

/// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String mEmailNullError = "Please enter your email";
const String mInvalidEmailError = "Please enter valid email";
const String mPassNullError = "Please enter your password";
const String mShortPassError = "Password is too short, at least 6 characters";
const String mMatchPassError = "Password don't match";
const String mNamelNullError = "Please enter your name";
const String mPhoneNumberNullError = "Please enter your phone number";
const String mAddressNullError = "Please enter your address";

/// Style
OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide(color: mTextColor),
  );
}

TextStyle headingStyle() {
  return TextStyle(
    color: Colors.black,
    fontSize: getProportionateScreenWidth(28),
    fontWeight: FontWeight.bold,
  );
}

enum MenuState { home, profile }
