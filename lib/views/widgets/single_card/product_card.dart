import 'package:e_commerce_app/configs/router.dart';
import 'package:e_commerce_app/utils/common_func.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:e_commerce_app/business_logic/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRouter.show_details,
          arguments: product,
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: EdgeInsets.only(right: 10, left: 10, bottom: 20),
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 7),
              blurRadius: 12,
              color: Color(0XFFB0CCE1).withOpacity(0.4),
            ),
          ],
        ),
        child: Column(
          children: [
            /// Product image
            AspectRatio(
              aspectRatio: 1,
              child: FutureBuilder(
                future: loadImage(product.images[0]),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? Image.network(snapshot.data)
                      : SpinKitCircle(color: mPrimaryColor);
                },
              ),
            ),

            /// Product name
            Text(
              product.name,
              style: TextStyle(
                fontSize: 13,
              ),
              textAlign: TextAlign.start,
              maxLines: 2,
            ),

            /// Product price and is available
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${formatNumber(product.originalPrice)} VNĐ",
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
                    color: product.isAvailable
                        ? Color(0xFFFFE6E6)
                        : Color(0xFFF5F6F9),
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    "assets/icons/Check mark rounde.svg",
                    color: product.isAvailable
                        ? Color(0xFFFF4848)
                        : Colors.black26,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
