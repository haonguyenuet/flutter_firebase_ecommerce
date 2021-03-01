import 'package:e_commerce_app/business_logic/entities/category.dart';
import 'package:e_commerce_app/constants/color_constant.dart';
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
          var _categories = state.categories;
          var _selectedCategoryIndex = state.selectedCategoryIndex;
          return ListCategory(
            categories: _categories,
            selectedCategoryIndex: _selectedCategoryIndex,
          );
        }
        return Center(child: Text("Something went wrongs."));
      },
    );
  }
}

/// List category
class ListCategory extends StatefulWidget {
  final List<Category> categories;
  final int selectedCategoryIndex;

  const ListCategory({
    Key key,
    @required this.categories,
    this.selectedCategoryIndex,
  }) : super(key: key);

  @override
  _ListCategoryState createState() => _ListCategoryState();
}

class _ListCategoryState extends State<ListCategory> {
  List<Category> get categories => widget.categories;
  int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedCategoryIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.symmetric(vertical: 10),
      color: mDarkShadeColor,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories.length,
        itemBuilder: (context, index) {
          return CategoryCard(
            category: categories[index],
            isActive: index == selectedIndex,
            onPressed: () {
              BlocProvider.of<AllProductsBloc>(context)
                  .add(CategoryChanged(categories[index]));
              setState(() {
                selectedIndex = index;
              });
            },
          );
        },
      ),
    );
  }
}
