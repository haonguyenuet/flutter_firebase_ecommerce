import 'package:e_commerce_app/components/product_card.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';

import 'package:provider/provider.dart';

class ListProducts extends StatelessWidget {
  ListProducts({Key key, this.category}) : super(key: key);
  final String category;

  @override
  Widget build(BuildContext context) {
    List<Product> products = category == "all"
        ? context.watch<List<Product>>()
        : context
            .watch<List<Product>>()
            .where((p) => p.type == category)
            .toList();
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: products == null
          ? CircularProgressIndicator()
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                mainAxisSpacing: 10,
                crossAxisSpacing: 0,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductCard(product: products[index]);
              },
            ),
    );
  }
}
