import 'package:e_commerce_app/constants/constants.dart';
import 'package:flutter/material.dart';

import 'package:e_commerce_app/configs/size_config.dart';

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.imageLink,
    required this.numberOfBrands,
    required this.offerName,
    required this.handleOnTap,
  }) : super(key: key);

  final String imageLink;
  final int numberOfBrands;
  final String offerName;
  final Function handleOnTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleOnTap as void Function()?,
      child: Container(
        margin: EdgeInsets.only(left: 20),
        height: getProportionateScreenWidth(110),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Image.asset(
                imageLink,
                fit: BoxFit.contain,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF343434).withOpacity(0.4),
                      Color(0xFF343434).withOpacity(0.15),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 20,
                child: Text(
                  "$offerName\n",
                  style: FONT_CONST.BOLD_WHITE_26,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
