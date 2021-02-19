import 'package:e_commerce_app/components/product_card.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/providers/product_provider.dart';
import 'package:e_commerce_app/screens/home_page/components/section.dart';
import 'package:e_commerce_app/screens/home_page/components/special_offers.dart';
import 'package:e_commerce_app/size_config.dart';
import 'package:flutter/material.dart';

import 'home_banner.dart';
import 'home_categories.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Product> products = context.watch<ProductProvider>().products ?? [];
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              HomeBanner(),
              HomeCategories(),
              Section(
                title: "Popular product",
                children: products.map((p) => ProductCard(product: p)).toList(),
              ),
              SpecialOffers()
            ],
          ),
        ),
      ),
    );
  }
}
