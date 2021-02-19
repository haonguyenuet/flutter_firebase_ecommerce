import 'package:e_commerce_app/screens/cart/cart_screen.dart';

import 'package:flutter/material.dart';

import 'icon_button_with_counter.dart';

class CartButton extends StatelessWidget {
  final int counter;

  const CartButton({Key key, this.counter}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IconButtonWithCounter(
      svgIcon: "assets/icons/Cart Icon.svg",
      onPressed: () => Navigator.pushNamed(context, CartScreen.routeName),
      counter: counter,
    );
  }
}
