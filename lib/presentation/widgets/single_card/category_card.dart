import 'package:e_commerce_app/business_logic/entities/entites.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/presentation/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

import 'package:e_commerce_app/configs/size_config.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.category,
    this.onPressed,
  }) : super(key: key);

  final Category category;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              ShimmerImage(
                imageUrl: category.imageUrl,
                height: SizeConfig.defaultSize * 9,
              ),
              Positioned(
                bottom: -SizeConfig.defaultSize * 2,
                left: SizeConfig.defaultSize * 2,
                child: Text(
                  "${category.name}\n",
                  style: FONT_CONST.BOLD_WHITE_16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
