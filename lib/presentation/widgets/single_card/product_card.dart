import 'package:e_commerce_app/configs/router.dart';

import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:e_commerce_app/business_logic/entities/product.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/utils/my_formatter.dart';
import 'package:e_commerce_app/presentation/widgets/custom_widgets.dart';
import 'package:e_commerce_app/presentation/widgets/others/custom_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      onTap: () => Navigator.pushNamed(
        context,
        AppRouter.DETAIL_PRODUCT,
        arguments: product,
      ),
      width: SizeConfig.defaultSize * 18,
      padding: EdgeInsets.all(SizeConfig.defaultSize),
      margin: EdgeInsets.all(SizeConfig.defaultSize * 0.5),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildProductImage(),
              _buildProductName(),
              _buildPriceAndAvailable(),
              _buildSoldQuantity()
            ],
          ),

          // Percent off
          if (product.percentOff > 0) _buildPercentOff(),
        ],
      ),
    );
  }

  _buildProductImage() {
    return ShimmerImage(
      aspectRatio: 1,
      imageUrl: product.images[0],
    );
  }

  _buildProductName() =>
      Text(product.name, style: FONT_CONST.REGULAR_DEFAULT, maxLines: 2);

  _buildPriceAndAvailable() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${formatNumber(product.price)}₫",
          style: FONT_CONST.MEDIUM_PRIMARY,
        ),
        Container(
          padding: EdgeInsets.all(5),
          width: SizeConfig.defaultSize * 2,
          height: SizeConfig.defaultSize * 2,
          decoration: BoxDecoration(
            color: product.isAvailable ? Color(0xFFFFE6E6) : Color(0xFFF5F6F9),
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            "assets/icons/Check mark rounde.svg",
            color: product.isAvailable ? Color(0xFFFF4848) : Colors.black26,
          ),
        ),
      ],
    );
  }

  _buildSoldQuantity() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text.rich(
        TextSpan(
          style: TextStyle(fontSize: 12),
          children: [
            TextSpan(text: "Đã bán:"),
            TextSpan(
              text: " ${product.soldQuantity}",
              style: FONT_CONST.MEDIUM_PRIMARY,
            ),
            TextSpan(text: " sản phẩm"),
          ],
        ),
      ),
    );
  }

  _buildPercentOff() {
    return Positioned(
      top: 0,
      right: 0,
      child: Container(
        alignment: Alignment.center,
        height: SizeConfig.defaultSize * 4,
        width: SizeConfig.defaultSize * 4,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: mPrimaryColor,
        ),
        child: Text("-${product.percentOff}%", style: FONT_CONST.BOLD_WHITE),
      ),
    );
  }
}
