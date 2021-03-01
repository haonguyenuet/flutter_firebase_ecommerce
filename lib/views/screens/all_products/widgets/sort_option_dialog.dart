import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/views/screens/all_products/bloc/bloc.dart';
import 'package:e_commerce_app/views/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class SortOptionDialog extends StatefulWidget {
  final ProductSortOption currSortOption;
  const SortOptionDialog({Key key, this.currSortOption}) : super(key: key);
  @override
  _SortOptionDialogState createState() => _SortOptionDialogState();
}

class _SortOptionDialogState extends State<SortOptionDialog> {
  ProductSortOption sortOption;

  @override
  void initState() {
    super.initState();
    sortOption = widget.currSortOption;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Sort options",
        style: TextStyle(
          color: mPrimaryColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Wrap(
            children: [
              Text("Sort by:"),
              SizedBox(width: 10),
              RadioListTile(
                title: Text("Price"),
                value: PRODUCT_SORT_BY.PRICE,
                groupValue: sortOption?.productSortBy,
                onChanged: (value) {
                  print(value);
                  setState(() =>
                      sortOption = sortOption.update(productSortBy: value));
                },
              ),
              RadioListTile(
                title: Text("Name"),
                value: PRODUCT_SORT_BY.NAME,
                groupValue: sortOption?.productSortBy,
                onChanged: (value) {
                  setState(() =>
                      sortOption = sortOption.update(productSortBy: value));
                },
              )
            ],
          ),
          Wrap(
            children: [
              Text("Sort order:"),
              SizedBox(width: 10),
              RadioListTile(
                title: Text("Ascending"),
                value: PRODUCT_SORT_ORDER.ASCENDING,
                groupValue: sortOption?.productSortOrder,
                onChanged: (value) {
                  setState(() =>
                      sortOption = sortOption.update(productSortOrder: value));
                },
              ),
              RadioListTile(
                title: Text("Descending"),
                value: PRODUCT_SORT_ORDER.DESCENDING,
                groupValue: sortOption?.productSortOrder,
                onChanged: (value) {
                  setState(() =>
                      sortOption = sortOption.update(productSortOrder: value));
                },
              )
            ],
          ),
          SizedBox(height: 10),
          DefaultButton(
            onPressed: () {
              // Because productSortOrder default is descending, so it's not null
              if (sortOption.productSortBy != null) {
                Navigator.pop(context, sortOption);
              }
            },
            child: Text("Select", style: mPrimaryFontStyle),
          )
        ],
      ),
    );
  }
}
