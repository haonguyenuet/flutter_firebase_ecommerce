import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/presentation/screens/all_products/bloc/bloc.dart';
import 'package:e_commerce_app/presentation/widgets/custom_widgets.dart';
import 'package:e_commerce_app/presentation/widgets/others/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GridProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllProductsBloc, AllProductsState>(
      buildWhen: (prevState, currState) {
        return currState is DisplayListProducts;
      },
      builder: (context, state) {
        if (state is DisplayListProducts) {
          if (state.loading!) {
            return Loading();
          }
          if (state.msg!.isNotEmpty) {
            return Center(child: Text(state.msg!));
          }
          if (state.products!.length > 0) {
            var products = state.products!;
            return GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 15 / 21,
                mainAxisSpacing: SizeConfig.defaultSize,
                crossAxisSpacing: 0,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductCard(product: products[index]);
              },
            );
          }
          return Center(
              child: Image.asset(
            "assets/images/Not Found.png",
            width: SizeConfig.defaultSize * 20,
          ));
        } else {
          return Center(child: Text("Something went wrong."));
        }
      },
    );
  }
}
