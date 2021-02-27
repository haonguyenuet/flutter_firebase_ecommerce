import 'package:e_commerce_app/business_logic/entities/category.dart';
import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:e_commerce_app/views/screens/all_products/bloc/all_products_bloc.dart';
import 'package:e_commerce_app/views/screens/all_products/bloc/all_products_event.dart';
import 'package:e_commerce_app/views/screens/all_products/bloc/all_products_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

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
  int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedCategoryIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories.length,
        itemBuilder: (context, index) {
          return _buildCategoryCard(
            context,
            widget.categories[index],
            index,
          );
        },
      ),
    );
  }

  _buildCategoryCard(BuildContext context, Category category, int index) {
    return InkWell(
      onTap: () {
        BlocProvider.of<AllProductsBloc>(context)
            .add(CategoryChanged(category));
        setState(() {
          selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: mAnimationDuration,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color:
                  selectedIndex == index ? mPrimaryColor : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              category.iconPath,
              width: 24,
              height: 24,
            ),
            SizedBox(width: 8),
            Text(
              category.name,
              style: TextStyle(
                color: selectedIndex == index ? mPrimaryColor : mTextColor,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
