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
      height: getProportionateScreenHeight(50),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 6),
            blurRadius: 10,
            color: mPrimaryColor.withOpacity(0.3),
          ),
        ],
      ),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        color: mPrimaryColor,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        onPressed: handleOnPress,
      ),
    );
  }
}
