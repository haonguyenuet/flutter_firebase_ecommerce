import 'package:e_commerce_app/providers/cart_provider.dart';
import 'package:e_commerce_app/screens/cart/components/body.dart';
import 'package:e_commerce_app/screens/cart/components/check_out_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text("Your cart"),
      actions: [
        IconButton(
          icon: Icon(Icons.clear_all_rounded),
          tooltip: "Clear all",
          onPressed: () {
            // clear all items in cart
            context.read<CartProvider>().clearCart();
          },
        )
      ],
    );
  }
}
