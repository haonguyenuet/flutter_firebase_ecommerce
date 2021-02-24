import 'package:e_commerce_app/business_logic/entities/category.dart';
import 'package:e_commerce_app/views/screens/category/category_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:e_commerce_app/configs/size_config.dart';

class HomeCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var categories = [];
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Category",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Wrap(
                spacing: getProportionateScreenWidth(25),
                children: [
                  ...categories.map((c) => CategoryCard(category: c)).toList(),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({
    Key key,
    @required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => handleOnTap(context),
      child: SizedBox(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(65),
              decoration: BoxDecoration(
                color: mPrimaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(category.iconPath, color: mPrimaryColor),
            ),
            SizedBox(height: 5),
            Text(category.name, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }

  void handleOnTap(BuildContext context) {
    Navigator.pushNamed(
      context,
      CategoryScreen.routeName,
    );
  }
}
