import 'package:e_commerce_app/business_logic/entities/entites.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/presentation/widgets/custom_widgets.dart';
import 'package:e_commerce_app/utils/utils.dart';
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
        child: Stack(
          children: [
            ShimmerImage(
              borderRadius: BorderRadius.circular(5),
              imageUrl: category.imageUrl,
            ),
            Positioned(
              bottom: SizeConfig.defaultSize,
              left: SizeConfig.defaultSize * 2,
              child: Text(
                Translate.of(context).translate("${category.name}"),
                style: FONT_CONST.BOLD_WHITE_18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
