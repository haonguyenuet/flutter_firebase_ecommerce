import 'package:e_commerce_app/business_logic/entities/product.dart';
import 'package:e_commerce_app/views/screens/detail_product/widgets/app_bar.dart';
import 'package:e_commerce_app/views/screens/detail_product/widgets/product_images.dart';
import 'package:e_commerce_app/views/screens/detail_product/widgets/product_info.dart';
import 'package:e_commerce_app/views/screens/detail_product/widgets/related_products/related_products.dart';
import 'package:e_commerce_app/views/screens/detail_product/widgets/slogan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'widgets/add_to_cart_nav.dart';

class DetailProductScreen extends StatelessWidget {
  final Product product;

  DetailProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            DetailProductAppBar(),
            Expanded(
              child: ListView(
                children: [
                  ProductImages(product: product),
                  ProductInfo(product: product),
                  Slogan(),
                  RelatedProducts(product: product),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: AddToCartNavigation(product: product),
    );
  }
}
