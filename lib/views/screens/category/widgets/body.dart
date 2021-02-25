import 'package:e_commerce_app/business_logic/entities/product.dart';

import 'package:flutter/material.dart';
import 'package:e_commerce_app/views/widgets/single_card/product_card.dart';

import 'header_sliver.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Product> products = [];
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: HeaderSliver(
              minExtent: 120,
              maxExtent: 120,
            ),
          ),
          SliverGrid.count(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            mainAxisSpacing: 10,
            crossAxisSpacing: 0,
            children: products.map((p) => ProductCard(product: p)).toList(),
          ),
        ],
      ),
    );
  }
}
