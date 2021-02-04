import 'package:flutter/material.dart';

import '../../../size_config.dart';

class TopRoundedContainer extends StatelessWidget {
  const TopRoundedContainer({
    Key key,
    this.child,
    this.roundedSize,
  }) : super(key: key);

  final Widget child;
  final double roundedSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenWidth(20)),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(roundedSize),
          topRight: Radius.circular(roundedSize),
        ),
      ),
      child: child,
    );
  }
}
