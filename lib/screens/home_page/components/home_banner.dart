import 'package:flutter/material.dart';

import '../../../size_config.dart';

class HomeBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(15),
        vertical: getProportionateScreenWidth(5),
      ),
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.asset(
          "assets/images/sale_banner.jpg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
