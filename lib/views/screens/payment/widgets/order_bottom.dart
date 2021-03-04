import 'package:e_commerce_app/business_logic/blocs/cart/bloc.dart';
import 'package:e_commerce_app/constants/style_constant.dart';
import 'package:e_commerce_app/utils/my_formatter.dart';
import 'package:e_commerce_app/views/widgets/buttons/default_button.dart';
import 'package:e_commerce_app/constants/color_constant.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class OrderBottom extends StatelessWidget {
  const OrderBottom({
    Key? key,
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
              offset: Offset(0, -0.5),
              color: Colors.black12,
              blurRadius: 5,
            )
          ],
        ),
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            return Column(
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
                    SizedBox(width: 15),
                    state is CartLoaded ? _buildTotalPrice(state) : Container(),
                  ],
                ),
                SizedBox(height: 20),

                /// Checkout button
                DefaultButton(
                  child: Text("Order", style: mPrimaryFontStyle),
                  onPressed: () {},
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  _buildTotalPrice(CartLoaded state) {
    var totalPriceOfGoods = formatNumber(state.totalCartPrice);
    var totalDeliveryFee = formatNumber(30000);
    var totalPrice = formatNumber(state.totalCartPrice + 30000);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Total cost of goods: $totalPriceOfGoods₫",
          style: TextStyle(fontSize: 16, color: mTextColor),
        ),
        Text(
          "Total delivery fee: $totalDeliveryFee₫",
          style: TextStyle(fontSize: 16, color: mTextColor),
        ),
        Text.rich(
          TextSpan(
            style: TextStyle(color: mSecondaryColor, fontSize: 16),
            children: [
              TextSpan(text: "Total: "),
              TextSpan(
                text: "$totalPrice₫",
                style: TextStyle(fontSize: 18, color: mPrimaryColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
