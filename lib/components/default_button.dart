import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class DefaultButton extends StatelessWidget {
  DefaultButton({
    Key key,
    this.handleOnPress,
    this.text,
  }) : super(key: key);

  final String text;
  final Function handleOnPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: FlatButton(
        color: mPrimaryColor,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: getProportionateScreenWidth(18),
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: handleOnPress,
      ),
    );
  }
}
