import 'package:e_commerce_app/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../constants.dart';

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
    return Column(
      children: categories.map((c) {
        return CategoryItem(
          iconPath: c.icon,
          title: c.name,
          isSelected: this.selectedCategory.id == c.id,
          onTap: () {
            toggle(c);
          },
        );
      }).toList(),
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
