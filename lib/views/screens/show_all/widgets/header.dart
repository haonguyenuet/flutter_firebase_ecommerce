import 'package:e_commerce_app/business_logic/entities/category.dart';
import 'package:e_commerce_app/views/widgets/buttons/cart_button.dart';
import 'package:e_commerce_app/views/screens/show_all/widgets/action_button.dart';
import 'package:flutter/material.dart';
import 'filter_category_bottom_sheet.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _currentCategory = Category.all;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 10.0,
            color: Colors.black.withOpacity(0.05),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Back button
              Container(
                width: 60,
                alignment: Alignment.centerLeft,
                child: InkWell(
                    child: Icon(Icons.arrow_back_ios),
                    onTap: () => Navigator.pop(context)),
              ),
              // Title
              Text(
                "Danh sách sản phẩm",
                style: TextStyle(fontSize: 18),
              ),
              // Cart Button
              CartButton(counter: 8),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ActionButton(
                  name: "${_currentCategory.name}",
                  iconPath: "assets/icons/controls.svg",
                  handleOnTap: () => _settingFilterCategoryBottomSheet(context),
                ),
              ),
              VerticalSeparator(),
              Expanded(
                child: ActionButton(
                  name: "Sort",
                  iconPath: "assets/icons/sort.svg",
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

void _settingFilterCategoryBottomSheet(context) {
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    context: context,
    builder: (BuildContext context) {
      return FilterCategoryBottomSheet();
    },
  );
}

class VerticalSeparator extends StatelessWidget {
  const VerticalSeparator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      width: 1,
      height: 20,
    );
  }
}
