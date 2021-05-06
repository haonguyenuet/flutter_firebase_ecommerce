import 'package:e_commerce_app/configs/config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:flutter/material.dart';

class PromoWidget extends StatelessWidget {
  final List<Map<String, dynamic>> coupons = [
    {
      "content": "Save 200k with orders from 2.000.000đ and up",
      "expDate": "05/04/2021"
    },
    {
      "content": "Save 500k with orders from 5.000.000đ and up",
      "expDate": "10/04/2021"
    },
    {
      "content": "Save 1000k with orders from 12.000.000đ and up",
      "expDate": "30/04/2021"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.defaultPadding,
          vertical: SizeConfig.defaultSize,
        ),
        child: Row(
          children: List.generate(
              coupons.length,
              (index) => _buildCouponCard(
                    coupons[index]["content"],
                    coupons[index]["expDate"],
                  )),
        ),
      ),
    );
  }

  _buildCouponCard(String content, String expireDate) {
    return Container(
      constraints: BoxConstraints(maxWidth: SizeConfig.screenWidth * 0.75),
      padding: EdgeInsets.all(SizeConfig.defaultPadding),
      margin: EdgeInsets.only(right: SizeConfig.defaultSize * 2),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: COLOR_CONST.primaryColor, width: 6),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            spreadRadius: 1,
            color: COLOR_CONST.cardShadowColor.withOpacity(0.3),
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            content,
            style: FONT_CONST.BOLD_DEFAULT_18,
            maxLines: 2,
            textWidthBasis: TextWidthBasis.longestLine,
          ),
          const SizedBox(height: 5),
          Text("EXP: " + expireDate),
        ],
      ),
    );
  }
}
