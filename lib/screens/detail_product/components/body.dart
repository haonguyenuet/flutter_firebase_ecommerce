import 'package:e_commerce_app/components/product_card.dart';
import 'package:e_commerce_app/components/section.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/providers/product_provider.dart';
import 'package:e_commerce_app/screens/detail_product/components/product_images.dart';
import 'package:e_commerce_app/screens/detail_product/components/product_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  final Product product;

  const Body({
    Key key,
    this.product,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Product get product => widget.product;
  // init states
  @override
  Widget build(BuildContext context) {
    // Get related products list by current product's category
    List<Product> relatedProducts = context
        .watch<ProductProvider>()
        .products
        .where((p) => p.categoryId == product.categoryId && p.id != product.id)
        .toList();

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            ProductImages(product: product),
            SizedBox(height: 10),
            ProductInfo(product: product),

            /// Section: Related products
            Section(
              title: "Related product",
              children:
                  relatedProducts.map((p) => ProductCard(product: p)).toList(),
              handleOnTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
