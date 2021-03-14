import 'package:flutter/material.dart';

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: Colors.white,
    elevation: 0,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.black),
    centerTitle: true,
    textTheme: TextTheme(
      headline6: TextStyle(color: Color(0xFF636e72), fontSize: 20),
    ),
  );
}
