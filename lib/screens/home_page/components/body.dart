import 'package:e_commerce_app/screens/home_page/components/special_offers.dart';
import 'package:e_commerce_app/size_config.dart';
import 'package:flutter/material.dart';

import 'home_banner.dart';
import 'home_categories.dart';
import 'home_header.dart';
import 'popular_products.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              HomeHeader(),
              SizedBox(height: getProportionateScreenHeight(20)),
              HomeBanner(),
              SizedBox(height: getProportionateScreenHeight(20)),
              HomeCategories(),
              SizedBox(height: getProportionateScreenHeight(20)),
              PopularProducts(),
              SizedBox(height: getProportionateScreenHeight(20)),
              SpecialOffers(),
            ],
          ),
        ),
      ),
    );
  }
}
