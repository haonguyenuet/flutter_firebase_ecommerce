import 'package:e_commerce_app/components/default_button.dart';
import 'package:e_commerce_app/providers/category_filter.dart';
import 'package:e_commerce_app/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import 'category_list.dart';

class FilterCategoryBottomSheet extends StatefulWidget {
  @override
  _FilterCategoryBottomSheetState createState() =>
      _FilterCategoryBottomSheetState();
}

class _FilterCategoryBottomSheetState extends State<FilterCategoryBottomSheet> {
  // init states

  void close() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var _currentCategory =
        context.watch<CategoryFilterProvider>().currentCategory;
    // initial value
    var _selectedCategory = _currentCategory;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Wrap(
          children: [
            /// Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  child: Icon(Icons.close),
                  onTap: () {
                    close();
                  },
                ),
                Text(
                  'Filter',
                  style: TextStyle(fontSize: 16),
                ),
                InkWell(
                  child: Text(
                    'Reset',
                    textAlign: TextAlign.right,
                    style: TextStyle(color: mPrimaryColor, fontSize: 16),
                  ),
                  onTap: () {},
                )
              ],
            ),

            /// Category Filter
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Category Filter',
                    style: TextStyle(fontSize: 20),
                  ),
                  CategoryList(
                    onSelect: (selectedCategory) {
                      _selectedCategory = selectedCategory;
                    },
                    currentCategory: _currentCategory,
                  ),
                ],
              ),
            ),

            /// Apply button
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: DefaultButton(
                handleOnPress: () {
                  // Change current category
                  context.read<CategoryFilterProvider>().setFilter(
                        currentCategory: _selectedCategory,
                      );
                  // Get products again
                  context
                      .read<ProductProvider>()
                      .getProductsByCategory(_selectedCategory);
                  close();
                },
                text: "Apply",
              ),
            )
          ],
        ),
      ),
    );
  }
}
