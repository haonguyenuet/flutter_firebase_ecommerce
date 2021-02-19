import 'package:e_commerce_app/components/default_button.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/screens/detail_product/components/product_images.dart';
import 'package:e_commerce_app/screens/detail_product/components/product_info.dart';
import 'package:e_commerce_app/size_config.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

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
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            ProductImages(product: product),
            SizedBox(height: 10),
            ProductInfo(product: product),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
