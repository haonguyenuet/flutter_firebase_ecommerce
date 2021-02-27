import 'package:e_commerce_app/business_logic/entities/category.dart';
import 'package:e_commerce_app/views/widgets/buttons/default_button.dart';

import 'package:flutter/material.dart';

import 'package:e_commerce_app/constants/color_constant.dart';
import 'category_list.dart';

class FilterCategoryBottomSheet extends StatefulWidget {
  @override
  _FilterCategoryBottomSheetState createState() =>
      _FilterCategoryBottomSheetState();
}

class _FilterCategoryBottomSheetState extends State<FilterCategoryBottomSheet> {
  // local states

  void close() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var _currentCategory = Category.all;
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
                onPressed: () {
                  // Change filter category
                },
                child: Text("Apply"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
