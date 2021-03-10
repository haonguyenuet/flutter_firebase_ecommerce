import 'package:e_commerce_app/business_logic/entities/entites.dart';
import 'package:e_commerce_app/business_logic/repository/repository.dart';
import 'package:e_commerce_app/configs/router.dart';
import 'package:e_commerce_app/views/screens/detail_product/widgets/related_products/bloc/bloc.dart';
import 'package:e_commerce_app/views/widgets/others/section.dart';
import 'package:e_commerce_app/views/widgets/single_card/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RelatedProducts extends StatelessWidget {
  final Product product;

  const RelatedProducts({Key? key, required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RelatedProductsBloc(
        productRepository: RepositoryProvider.of<ProductRepository>(context),
      )..add(LoadRelatedProducts(product)),
      child: BlocBuilder<RelatedProductsBloc, RelatedProductsState>(
        builder: (context, state) {
          if (state is RelatedProductsLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is RelatedProductsLoadFailure) {
            return Center(child: Text("Loading Failure"));
          }
          if (state is RelatedProductsLoaded) {
            return Section(
              title: "Related product",
              children: state.relatedProducts
                  .map((p) => ProductCard(product: p))
                  .toList(),
              handleOnSeeAll: () {
                Navigator.pushNamed(context, AppRouter.ALL_PRODUCTS);
              },
            );
          }
          return Center(child: Text("Unknown state"));
        },
      ),
    );
  }
}
