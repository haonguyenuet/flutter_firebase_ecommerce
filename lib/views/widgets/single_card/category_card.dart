import 'package:e_commerce_app/business_logic/entities/category.dart';
import 'package:e_commerce_app/views/screens/category/category_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:e_commerce_app/configs/size_config.dart';

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
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              width: getProportionateScreenWidth(90),
              height: getProportionateScreenWidth(65),
              decoration: BoxDecoration(
                color: mPrimaryColor.withOpacity(0.9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(
                category.iconPath,
                width: 50,
                height: 50,
              ),
            ),
            SizedBox(height: 5),
            Text(
              category.name,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            )
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
