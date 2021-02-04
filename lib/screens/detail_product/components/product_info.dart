import 'package:e_commerce_app/common/common_func.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

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
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _productName(),
          SizedBox(height: 2),
          _price(),
          SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _rating(),
              _favourite(),
            ],
          ),
          SizedBox(height: 10),
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
        "${formatNumber(product.price)} VNĐ",
        style: TextStyle(
          fontSize: 20,
          color: mPrimaryColor,
        ),
      ),
    );
  }

  Row _rating() {
    return Row(
      children: [
        SizedBox(width: getProportionateScreenWidth(20)),
        ...List.generate(5, (index) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(right: 5),
              padding: EdgeInsets.all(5),
              height: getProportionateScreenWidth(20),
              width: getProportionateScreenWidth(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFF5F6F9),
              ),
              child: SvgPicture.asset("assets/icons/Star Icon.svg"),
            ),
          );
        })
      ],
    );
  }

  Align _favourite() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        height: 40,
        decoration: BoxDecoration(
          color: product.isFavourite ? Color(0xFFFFE6E6) : Color(0xFFF5F6F9),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/Check mark rounde.svg",
              color:
                  product.isFavourite ? Color(0xFFFF4848) : Color(0xFFDBDEE4),
            ),
            SizedBox(width: 5),
            Text("${product.isFavourite ? "Còn hàng" : "Hết hàng"}"),
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
        maxLines: seeMore ? null : 3,
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
          "See more",
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
