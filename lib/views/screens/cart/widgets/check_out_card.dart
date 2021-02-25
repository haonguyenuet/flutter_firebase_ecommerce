import 'package:e_commerce_app/utils/common_func.dart';
import 'package:e_commerce_app/views/widgets/buttons/default_button.dart';
import 'package:e_commerce_app/constants/color_constant.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_app/configs/size_config.dart';

class CheckoutCard extends StatelessWidget {
  const CheckoutCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        text: "${100000}",
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
              child: Text("Check Out"),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
