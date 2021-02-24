import 'package:e_commerce_app/business_logic/entities/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:e_commerce_app/constants/color_constant.dart';

class CategoryList extends StatefulWidget {
  final Function(Category) onSelect;
  final Category currentCategory;

  const CategoryList({
    Key key,
    @required this.onSelect,
    @required this.currentCategory,
  }) : super(key: key);

  @override
  _FilterListState createState() => _FilterListState();
}

class _FilterListState extends State<CategoryList> {
  Category selectedCategory;

  @override
  void initState() {
    selectedCategory = widget.currentCategory;
    super.initState();
  }

  toggle(Category category) {
    setState(() {
      selectedCategory = category;
      widget.onSelect(selectedCategory);
    });
  }

  @override
  Widget build(BuildContext context) {
    var categories =  [];
    return Column(
      children: [
        ...List.generate(categories.length, (index) {
          return CategoryItem(
            iconPath: categories[index].iconPath,
            title: categories[index].name,
            isSelected: this.selectedCategory.cid == categories[index].cid,
            onTap: () {
              toggle(categories[index]);
            },
          );
        })
      ],
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String iconPath;
  final String title;
  final bool isSelected;
  final Function onTap;

  const CategoryItem({
    Key key,
    @required this.iconPath,
    @required this.title,
    @required this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: mSecondaryColor,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
              width: 20,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check,
                color: mPrimaryColor,
              )
          ],
        ),
      ),
    );
  }
}
