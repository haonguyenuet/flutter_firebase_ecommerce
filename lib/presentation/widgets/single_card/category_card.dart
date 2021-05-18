import 'package:e_commerce_app/data/models/models.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/presentation/widgets/custom_widgets.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:e_commerce_app/configs/size_config.dart';

class CategoryModelCard extends StatelessWidget {
  const CategoryModelCard({
    Key? key,
    required this.category,
    this.onPressed,
  }) : super(key: key);

  final CategoryModel category;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
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
              style: FONT_CONST.BOLD_WHITE_20,
            ),
          ),
        ],
      ),
    );
  }
}
