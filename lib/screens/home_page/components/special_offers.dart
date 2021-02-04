import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'offer_card.dart';

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Text(
            "Special for you",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(10)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SpecialOfferCard(
                imageLink: "assets/images/Image Banner 2.png",
                offerName: "Smartphone",
                numberOfBrands: 18,
                handleOnTap: () {},
              ),
              SpecialOfferCard(
                imageLink: "assets/images/Image Banner 3.png",
                offerName: "Fashion",
                numberOfBrands: 24,
                handleOnTap: () {},
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        )
      ],
    );
  }
}
