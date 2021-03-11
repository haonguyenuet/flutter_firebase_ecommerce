import 'package:e_commerce_app/business_logic/entities/product.dart';
import 'package:e_commerce_app/configs/router.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/utils/my_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProductInfo extends StatefulWidget {
  const ProductInfo({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  Product get product => widget.product;
  // local states
  bool seeMore = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 3),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _productName(),
          SizedBox(height: SizeConfig.defaultSize * 0.5),
          _price(),
          SizedBox(height: SizeConfig.defaultSize * 2),
          Row(
            children: [
              SizedBox(width: SizeConfig.defaultSize * 1.5),
              _soldQuantity(),
              SizedBox(width: SizeConfig.defaultSize),
              Container(height: 15, width: 2, color: Colors.black12),
              SizedBox(width: SizeConfig.defaultSize),
              _rating(context),
              Spacer(),
              _isAvailable(),
            ],
          ),
          SizedBox(height: SizeConfig.defaultSize * 2),
          _description(),
        ],
      ),
    );
  }

  _productName() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 1.5),
      child: Text(product.name, style: FONT_CONST.MEDIUM_DEFAULT_20),
    );
  }

  _price() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 1.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${formatNumber(product.price)}₫",
            style: FONT_CONST.MEDIUM_PRIMARY_24,
          ),
          if (product.percentOff > 0)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                "${formatNumber(product.originalPrice)}₫",
                style: TextStyle(decoration: TextDecoration.lineThrough),
              ),
            ),
        ],
      ),
    );
  }

  _soldQuantity() {
    return Text.rich(
      TextSpan(
        style: FONT_CONST.BOLD_DEFAULT,
        children: [
          TextSpan(text: "Đã bán:"),
          TextSpan(
            text: " ${product.soldQuantity}",
            style: FONT_CONST.BOLD_PRIMARY_16,
          ),
        ],
      ),
    );
  }

  _rating(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRouter.FEEDBACK,
          arguments: product,
        );
      },
      child: Row(
        children: [
          Text("${product.rating}", style: FONT_CONST.BOLD_DEFAULT_16),
          SizedBox(width: 5),
          SvgPicture.asset("assets/icons/Star Icon.svg"),
        ],
      ),
    );
  }

  _isAvailable() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 1.5),
        alignment: Alignment.center,
        height: SizeConfig.defaultSize * 4,
        decoration: BoxDecoration(
          color: product.isAvailable ? Color(0xFFFFE6E6) : Color(0xFFF5F6F9),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(SizeConfig.defaultSize * 2.5),
            bottomLeft: Radius.circular(SizeConfig.defaultSize * 2.5),
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/Check mark rounde.svg",
              color:
                  product.isAvailable ? Color(0xFFFF4848) : Color(0xFFDBDEE4),
            ),
            SizedBox(width: 5),
            Text("${product.isAvailable ? "Còn hàng" : "Hết hàng"}"),
          ],
        ),
      ),
    );
  }

  _description() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 1.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.description,
            maxLines: seeMore ? null : 2,
          ),
          SizedBox(height: 5),

          // see more button
          GestureDetector(
            onTap: () {
              setState(() {
                seeMore = !seeMore;
              });
            },
            child: Text(
              "${seeMore ? "See less" : "See more"}",
              style: FONT_CONST.BOLD_PRIMARY,
            ),
          ),
        ],
      ),
    );
  }
}
