import 'package:e_commerce_app/views/widgets/product_card.dart';
import 'package:e_commerce_app/views/widgets/section.dart';
import 'package:e_commerce_app/business_logic/entities/product.dart';

import 'package:e_commerce_app/views/screens/category/category_screen.dart';
import 'package:e_commerce_app/views/screens/home_page/widgets/special_offers.dart';
import 'package:flutter/material.dart';

import 'home_banner.dart';
import 'home_categories.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Product> products = [];
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              HomeBanner(),
              HomeCategories(),

              /// Section : Popular product - products are most sold
              Section(
                title: "Popular product",
                children: products.map((p) => ProductCard(product: p)).toList(),
                handleOnTap: () {},
              ),
              SpecialOffers(),
            ],
          ),
        ),
      ),
    );
  }
}
