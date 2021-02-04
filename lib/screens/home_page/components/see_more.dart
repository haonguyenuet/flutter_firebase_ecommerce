import 'package:e_commerce_app/components/circle_icon_button.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SeeMore extends StatelessWidget {
  const SeeMore({
    Key key,
    this.handleOnPress,
  }) : super(key: key);

  final Function handleOnPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleIconButton(
          color: Colors.white,
          size: getProportionateScreenWidth(40),
          icon: Icon(Icons.arrow_forward_sharp),
          handleOnPress: handleOnPress,
        ),
        SizedBox(height: 5),
        Text(
          "Xem thêm",
          style: TextStyle(
            fontSize: 12,
            color: mSecondaryColor,
          ),
        ),
      ],
    );
  }
}
