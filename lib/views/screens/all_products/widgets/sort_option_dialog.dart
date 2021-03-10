import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/utils/my_dialog.dart';
import 'package:e_commerce_app/views/screens/all_products/bloc/bloc.dart';
import 'package:e_commerce_app/views/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class SortOptionDialog extends StatefulWidget {
  final ProductSortOption currSortOption;
  const SortOptionDialog({
    Key? key,
    required this.currSortOption,
  }) : super(key: key);
  @override
  _SortOptionDialogState createState() => _SortOptionDialogState();
}

class _SortOptionDialogState extends State<SortOptionDialog> {
  ProductSortOption? sortOption;

  @override
  void initState() {
    super.initState();
    sortOption = widget.currSortOption;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Sort options", style: FONT_CONST.BOLD_PRIMARY_18),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Sort by:"),
                SizedBox(width: SizeConfig.defaultSize),
                RadioListTile(
                  title: Text("Price"),
                  value: PRODUCT_SORT_BY.PRICE,
                  groupValue: sortOption?.productSortBy,
                  onChanged: (dynamic value) {
                    print(value);
                    setState(() =>
                        sortOption = sortOption!.update(productSortBy: value));
                  },
                ),
                RadioListTile(
                  title: Text("Sold Quantity"),
                  value: PRODUCT_SORT_BY.SOLD_QUANTITY,
                  groupValue: sortOption?.productSortBy,
                  onChanged: (dynamic value) {
                    setState(() =>
                        sortOption = sortOption!.update(productSortBy: value));
                  },
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Sort order:"),
                SizedBox(width: SizeConfig.defaultSize),
                RadioListTile(
                  title: Text("Descending"),
                  value: PRODUCT_SORT_ORDER.DESCENDING,
                  groupValue: sortOption?.productSortOrder,
                  onChanged: (dynamic value) {
                    setState(() => sortOption =
                        sortOption!.update(productSortOrder: value));
                  },
                ),
                RadioListTile(
                  title: Text("Ascending"),
                  value: PRODUCT_SORT_ORDER.ASCENDING,
                  groupValue: sortOption?.productSortOrder,
                  onChanged: (dynamic value) {
                    setState(() => sortOption =
                        sortOption!.update(productSortOrder: value));
                  },
                ),
              ],
            ),
            SizedBox(height: SizeConfig.defaultSize),
            DefaultButton(
              onPressed: () {
                // Because productSortOrder default is descending, so it's not null
                if (sortOption!.productSortBy != null) {
                  Navigator.pop(context, sortOption);
                } else {
                  MyDialog.showInformation(
                    context,
                    content: "Sort by isn't selected",
                  );
                }
              },
              child: Text("Select", style: FONT_CONST.BOLD_WHITE_18),
            )
          ],
        ),
      ),
    );
  }
}
