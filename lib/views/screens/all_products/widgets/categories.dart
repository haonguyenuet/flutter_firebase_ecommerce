import 'package:e_commerce_app/views/screens/all_products/bloc/all_products_bloc.dart';
import 'package:e_commerce_app/views/screens/all_products/bloc/all_products_event.dart';
import 'package:e_commerce_app/views/screens/all_products/bloc/all_products_state.dart';
import 'package:e_commerce_app/views/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllProductsBloc, AllProductsState>(
      buildWhen: (prevState, currState) {
        return currState is CategoriesLoaded;
      },
      builder: (context, state) {
        if (state is CategoriesLoaded) {
          var categories = state.categories;
          return Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return CategoryCard(
                  category: categories[index],
                  onPressed: () {
                    BlocProvider.of<AllProductsBloc>(context)
                        .add(CategoryChanged(categories[index]));
                  },
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }
}
