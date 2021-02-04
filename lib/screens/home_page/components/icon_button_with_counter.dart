import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class IconButtonWithCounter extends StatelessWidget {
  const IconButtonWithCounter({
    Key key,
    @required this.counter,
    @required this.svgIcon,
    this.handleOnTap,
  }) : super(key: key);

  final int counter;
  final String svgIcon;
  final Function handleOnTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: handleOnTap,
      borderRadius: BorderRadius.circular(getProportionateScreenWidth(20)),
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(12)),
            width: getProportionateScreenWidth(40),
            height: getProportionateScreenWidth(40),
            decoration: BoxDecoration(
              color: mSecondaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(svgIcon),
          ),
          if (counter > 0)
            Positioned(
              right: 0,
              top: -2,
              child: Container(
                width: getProportionateScreenWidth(15),
                height: getProportionateScreenWidth(15),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    "$counter",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: getProportionateScreenWidth(8),
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
