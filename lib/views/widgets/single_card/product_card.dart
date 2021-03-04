import 'package:e_commerce_app/configs/router.dart';

import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:e_commerce_app/business_logic/entities/product.dart';
import 'package:e_commerce_app/utils/my_formatter.dart';
import 'package:e_commerce_app/views/widgets/custom_widgets.dart';
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
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        AppRouter.DETAIL_PRODUCT,
        arguments: product,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          margin: EdgeInsets.all(10),
          width: 170,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 2),
                blurRadius: 6,
                color: mDarkShadeColor.withOpacity(0.2),
              ),
            ],
          ),
          child: Wrap(
            spacing: 5,
            children: [
              _buildProductImage(),
              _buildProductName(),
              _buildPriceAndAvailable(),
              _buildSoldQuantity()
            ],
          ),
        ),
      ),
    );
  }

  _buildProductImage() {
    return AspectRatio(
      aspectRatio: 1,
      child: ShimmerImage(
        aspectRatio: 1,
        imageUrl: product.images[0],
      ),
    );
  }

  _buildProductName() =>
      Text(product.name, style: TextStyle(fontSize: 13), maxLines: 2);

  _buildPriceAndAvailable() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${formatNumber(product.originalPrice)}₫",
          style: TextStyle(
            color: mPrimaryColor,
            fontSize: 14,
          ),
        ),
        Container(
          padding: EdgeInsets.all(5),
          width: getProportionateScreenWidth(20),
          height: getProportionateScreenWidth(20),
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
              style: TextStyle(fontSize: 13, color: mPrimaryColor),
            ),
            TextSpan(text: " sản phẩm"),
          ],
        ),
      ),
    );
  }
}
