import 'package:e_commerce_app/business_logic/entities/product.dart';
import 'package:e_commerce_app/business_logic/repository/product_repository/product_repo.dart';
import 'package:e_commerce_app/views/screens/detail_product/widgets/custom_appbar.dart';
import 'package:e_commerce_app/views/screens/detail_product/widgets/product_images.dart';
import 'package:e_commerce_app/views/screens/detail_product/widgets/product_info.dart';
import 'package:e_commerce_app/views/screens/detail_product/widgets/related_products/bloc/related_products_bloc.dart';
import 'package:e_commerce_app/views/screens/detail_product/widgets/related_products/bloc/related_products_event.dart';
import 'package:e_commerce_app/views/screens/detail_product/widgets/related_products/related_products.dart';
import 'package:e_commerce_app/views/screens/detail_product/widgets/slogan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/add_to_cart_nav.dart';

class DetailProductScreen extends StatelessWidget {
  final Product product;

  DetailProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RelatedProductsBloc(
            productRepository:
                RepositoryProvider.of<ProductRepository>(context),
          )..add(LoadRelatedProducts(product.id, product.categoryId)),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              CustomAppBar(product: product),
              Expanded(
                child: ListView(
                  children: [
                    ProductImages(product: product),
                    ProductInfo(product: product),
                    Slogan(),
                    RelatedProducts(),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: AddToCartNavigation(product: product),
      ),
    );
  }
}
