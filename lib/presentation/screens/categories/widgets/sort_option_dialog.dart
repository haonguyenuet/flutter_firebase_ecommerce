import 'package:e_commerce_app/configs/config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/presentation/screens/categories/bloc/bloc.dart';
import 'package:e_commerce_app/presentation/widgets/custom_widgets.dart';
import 'package:e_commerce_app/utils/utils.dart';
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
  late ProductSortOption sortOption;

  @override
  void initState() {
    super.initState();
    sortOption = widget.currSortOption;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        Translate.of(context).translate('sort_options'),
        style: FONT_CONST.BOLD_PRIMARY_18,
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${Translate.of(context).translate('sort_by')}:"),
                SizedBox(width: SizeConfig.defaultSize),
                RadioListTile(
                  title: Text(Translate.of(context).translate('price')),
                  value: PRODUCT_SORT_BY.PRICE,
                  groupValue: sortOption.productSortBy,
                  onChanged: (value) {
                    setState(() {
                      sortOption = sortOption.update(productSortBy: value);
                    });
                  },
                ),
                RadioListTile(
                  title: Text(Translate.of(context).translate('sold_quantity')),
                  value: PRODUCT_SORT_BY.SOLD_QUANTITY,
                  groupValue: sortOption.productSortBy,
                  onChanged: (value) {
                    setState(() {
                      sortOption = sortOption.update(productSortBy: value);
                    });
                  },
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${Translate.of(context).translate('sort_order')}:"),
                SizedBox(width: SizeConfig.defaultSize),
                RadioListTile(
                  title: Text(Translate.of(context).translate('descending')),
                  value: PRODUCT_SORT_ORDER.DESCENDING,
                  groupValue: sortOption.productSortOrderModel,
                  onChanged: (value) {
                    setState(() {
                      sortOption =
                          sortOption.update(productSortOrderModel: value);
                    });
                  },
                ),
                RadioListTile(
                  title: Text(Translate.of(context).translate('ascending')),
                  value: PRODUCT_SORT_ORDER.ASCENDING,
                  groupValue: sortOption.productSortOrderModel,
                  onChanged: (value) {
                    setState(() {
                      sortOption =
                          sortOption.update(productSortOrderModel: value);
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: SizeConfig.defaultSize),
            DefaultButton(
              onPressed: () {
                // productSortOrderModel default is descending, so it's not null
                if (sortOption.productSortBy != null) {
                  Navigator.pop(context, sortOption);
                } else {
                  UtilDialog.showInformation(
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
