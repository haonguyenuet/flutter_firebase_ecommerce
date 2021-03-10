import 'package:e_commerce_app/business_logic/entities/category.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/views/screens/all_products/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllProductsBloc, AllProductsState>(
      buildWhen: (prevState, currState) => currState is CategoriesLoaded,
      builder: (context, state) {
        if (state is CategoriesLoaded) {
          List<Category> _categories = state.categories;
          int _selectedCategoryIndex = state.selectedCategoryIndex;
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
    Key? key,
    required this.categories,
    required this.selectedCategoryIndex,
  }) : super(key: key);

  @override
  _ListCategoryState createState() => _ListCategoryState();
}

class _ListCategoryState extends State<ListCategory> {
  List<Category> get categories => widget.categories;
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedCategoryIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(
            categories.length,
            (index) => _buildCategoryTab(context, categories[index], index),
          ),
        ),
      ),
    );
  }

  _buildCategoryTab(BuildContext context, Category category, int index) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<AllProductsBloc>(context)
            .add(CategoryChanged(category));
        setState(() => selectedIndex = index);
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.defaultSize * 2,
              vertical: SizeConfig.defaultSize * 0.5,
            ),
            child: Text("${category.name}", style: FONT_CONST.BOLD_DEFAULT_16),
          ),
          if (index == selectedIndex)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 3,
                width: SizeConfig.defaultSize * 4,
                color: mPrimaryColor,
              ),
            )
        ],
      ),
    );
  }
}
