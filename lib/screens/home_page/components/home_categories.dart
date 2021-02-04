import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class HomeCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> categories = [
      {"icon": "assets/icons/Flash Icon.svg", "name": "Flash"},
      {"icon": "assets/icons/Bill Icon.svg", "name": "Bill"},
      {"icon": "assets/icons/Game Icon.svg", "name": "Game"},
      {"icon": "assets/icons/Gift Icon.svg", "name": "Daily Gift"},
      {"icon": "assets/icons/Discover.svg", "name": "More"},
    ];

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          categories.length,
          (index) => CategoryCard(
            svgIcon: categories[index]["icon"],
            categoryName: categories[index]["name"],
            handleOnTap: () {},
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key key,
    this.svgIcon,
    this.categoryName,
    this.handleOnTap,
  }) : super(key: key);

  final String svgIcon;
  final String categoryName;
  final Function handleOnTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleOnTap,
      child: Container(
        width: getProportionateScreenWidth(45),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                decoration: BoxDecoration(
                  color: mPrimaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgPicture.asset(svgIcon),
              ),
            ),
            Text(
              categoryName,
              style: TextStyle(
                color: mTextColor,
                fontSize: 12,
              ),
              maxLines: 2,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
