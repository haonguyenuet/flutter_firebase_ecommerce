import 'package:e_commerce_app/views/widgets/others/section.dart';
import 'package:flutter/material.dart';

import 'package:e_commerce_app/configs/size_config.dart';
import 'offer_card.dart';

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: "Special for you",
        ),
        SizedBox(height: getProportionateScreenHeight(10)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SpecialOfferCard(
                imageLink: "assets/images/Mechanical Keyboard.jpg",
                offerName: "Mechanical Keyboard",
                numberOfBrands: 18,
                handleOnTap: () {},
              ),
              SpecialOfferCard(
                imageLink: "assets/images/Mouse.jpg",
                offerName: "Mouse",
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
