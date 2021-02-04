import 'package:e_commerce_app/screens/cart/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'search_field.dart';
import 'icon_button_with_counter.dart';
import 'package:e_commerce_app/models/cart.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(),
          IconButtonWithCounter(
            counter: context.watch<Cart>().getCart.length,
            svgIcon: "assets/icons/Cart Icon.svg",
            handleOnTap: () {
              Navigator.pushNamed(context, CartScreen.routeName);
            },
          ),
          IconButtonWithCounter(
            counter: 2,
            svgIcon: "assets/icons/Bell.svg",
            handleOnTap: () {},
          ),
        ],
      ),
    );
  }
}
