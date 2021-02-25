import 'package:e_commerce_app/views/widgets/single_card/product_card.dart';
import 'package:e_commerce_app/views/widgets/others/section.dart';
import 'package:e_commerce_app/business_logic/entities/product.dart';
import 'package:e_commerce_app/views/screens/detail_product/widgets/product_images.dart';
import 'package:e_commerce_app/views/screens/detail_product/widgets/product_info.dart';
import 'package:flutter/material.dart';

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
    List<Product> relatedProducts = [];

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
