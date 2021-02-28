import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:e_commerce_app/views/screens/cart/widgets/cart_body.dart';
import 'package:e_commerce_app/views/screens/cart/widgets/check_out_card.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: CartBody(),
      bottomNavigationBar: CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text("Your cart"),
      actions: [
        IconButton(
          icon: Icon(Icons.clear_all_rounded, color: mAccentTintColor),
          tooltip: "Clear all",
          onPressed: () {},
        )
      ],
    );
  }
}
