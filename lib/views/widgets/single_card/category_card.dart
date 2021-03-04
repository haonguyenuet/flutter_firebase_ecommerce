import 'package:e_commerce_app/business_logic/entities/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:e_commerce_app/constants/color_constant.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final Function onPressed;
  final bool isActive;

  const CategoryCard({
    Key key,
    @required this.category,
    this.onPressed,
    this.isActive = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: isActive ? mAccentShadeColor : mDarkShadeColor,
          borderRadius: BorderRadius.circular(2),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              category.iconPath,
              width: 24,
              height: 24,
            ),
            SizedBox(width: 8),
            Text(
              category.name,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
