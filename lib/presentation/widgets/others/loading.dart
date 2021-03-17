import 'package:e_commerce_app/constants/constants.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(COLOR_CONST.primaryColor),
      ),
    );
  }
}
