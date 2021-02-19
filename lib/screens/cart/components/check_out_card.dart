import 'package:e_commerce_app/common/common_func.dart';
import 'package:e_commerce_app/components/default_button.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/models/cart_item.dart';
import 'package:e_commerce_app/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../size_config.dart';

class CheckoutCard extends StatelessWidget {
  const CheckoutCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cartProvider = context.watch<CartProvider>();

    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0.15, 0.6),
              color: Colors.black,
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Total price
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset("assets/icons/receipt.svg"),
                ),
                SizedBox(width: getProportionateScreenHeight(15)),
                Text.rich(
                  TextSpan(
                    style: TextStyle(color: mSecondaryColor, fontSize: 16),
                    children: [
                      TextSpan(text: "Total:\n"),
                      TextSpan(
                        text: "${formatNumber(cartProvider.getPrice())}",
                        style: TextStyle(fontSize: 18, color: mPrimaryColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(20)),

            /// Checkout button
            DefaultButton(
              text: "Check Out",
              handleOnPress: () {},
            ),
          ],
        ),
      ),
    );
  }
}
