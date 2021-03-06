import 'package:e_commerce_app/views/widgets/others/section.dart';
import 'package:flutter/material.dart';

import 'package:e_commerce_app/configs/size_config.dart';
import '../../../widgets/single_card/offer_card.dart';

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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SpecialOfferCard(
                imageLink: "assets/images/Mechanical Keyboard.jpg",
                offerName: "Akko",
                numberOfBrands: 18,
                handleOnTap: () {},
              ),
              SpecialOfferCard(
                imageLink: "assets/images/Mouse.jpg",
                offerName: "Razer",
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
