import 'package:e_commerce_app/business_logic/entities/product.dart';
import 'package:e_commerce_app/utils/my_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:e_commerce_app/configs/size_config.dart';

class ProductInfo extends StatefulWidget {
  const ProductInfo({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  Product get product => widget.product;
  // init states
  bool seeMore = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenWidth(20)),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFF5F6F9), width: 8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _price(),
          SizedBox(height: 5),
          _productName(),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _soldQuantity(),
              _isAvailable(),
            ],
          ),
          SizedBox(height: 30),
          _description(),
          SizedBox(height: 5),
          _seeMore()
        ],
      ),
    );
  }

  Padding _productName() {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Text(
        product.name,
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Padding _price() {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Text(
        "${formatNumber(product.originalPrice)} VNĐ",
        style: TextStyle(
          fontSize: 24,
          color: mPrimaryColor,
        ),
      ),
    );
  }

  Container _soldQuantity() {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Text.rich(
        TextSpan(
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          children: [
            TextSpan(text: "Đã bán:"),
            TextSpan(
              text: " ${product.soldQuantity}",
              style: TextStyle(fontSize: 16, color: mPrimaryColor),
            ),
            TextSpan(text: " sản phẩm"),
          ],
        ),
      ),
    );
  }

  Align _isAvailable() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        alignment: Alignment.center,
        height: 40,
        decoration: BoxDecoration(
          color: product.isAvailable ? Color(0xFFFFE6E6) : Color(0xFFF5F6F9),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            bottomLeft: Radius.circular(25),
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

  Padding _description() {
    return Padding(
      padding: EdgeInsets.only(
        left: getProportionateScreenWidth(20),
        right: getProportionateScreenWidth(60),
      ),
      child: Text(
        product.description,
        maxLines: seeMore ? null : 2,
      ),
    );
  }

  Padding _seeMore() {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: GestureDetector(
        onTap: () {
          setState(() {
            seeMore = !seeMore;
          });
        },
        child: Text(
          "${seeMore ? "See less" : "See more"}",
          style: TextStyle(
            color: mPrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
