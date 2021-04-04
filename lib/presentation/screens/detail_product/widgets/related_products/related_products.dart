import 'package:e_commerce_app/business_logic/entities/entites.dart';
import 'package:e_commerce_app/business_logic/repository/app_repository.dart';
import 'package:e_commerce_app/configs/router.dart';
import 'package:e_commerce_app/presentation/screens/detail_product/widgets/related_products/bloc/bloc.dart';
import 'package:e_commerce_app/presentation/widgets/others/section_widget.dart';
import 'package:e_commerce_app/presentation/widgets/single_card/product_card.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RelatedProducts extends StatelessWidget {
  final Product product;

  const RelatedProducts({Key? key, required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RelatedProductsBloc()..add(LoadRelatedProducts(product)),
      child: BlocBuilder<RelatedProductsBloc, RelatedProductsState>(
        builder: (context, state) {
          if (state is RelatedProductsLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is RelatedProductsLoadFailure) {
            return Center(child: Text("Loading Failure"));
          }
          if (state is RelatedProductsLoaded) {
            return SectionWidget(
              title: Translate.of(context).translate('related_products'),
              children: state.relatedProducts
                  .map((p) => ProductCard(product: p))
                  .toList(),
              handleOnSeeAll: () async {
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
