import 'package:e_commerce_app/data/models/models.dart';
import 'package:e_commerce_app/presentation/screens/detail_product/widgets/app_bar.dart';
import 'package:e_commerce_app/presentation/screens/detail_product/widgets/product_images.dart';
import 'package:e_commerce_app/presentation/screens/detail_product/widgets/product_info.dart';
import 'package:e_commerce_app/presentation/screens/detail_product/widgets/related_products/related_products.dart';
import 'package:e_commerce_app/presentation/screens/detail_product/widgets/slogan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'widgets/add_to_cart_nav.dart';

class DetailProductScreen extends StatelessWidget {
  final Product product;

  DetailProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            DetailProductAppBar(),
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  ProductImagesWidget(product: product),
                  ProductInfoWidget(product: product),
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
