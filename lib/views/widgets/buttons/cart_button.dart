import 'package:e_commerce_app/business_logic/blocs/cart/bloc.dart';
import 'package:e_commerce_app/configs/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'icon_button_with_counter.dart';

class CartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      buildWhen: (prevState, currState) => currState is CartLoaded,
      builder: (context, state) {
        if (state is CartLoaded) {
          var counter = state.cartResponse.cart.length;
          return IconButtonWithCounter(
            icon: Icons.shopping_bag_outlined,
            onPressed: () => Navigator.pushNamed(context, AppRouter.CART),
            counter: counter,
            size: 30,
          );
        }
        return IconButtonWithCounter(
          icon: Icons.shopping_bag_outlined,
          onPressed: () => Navigator.pushNamed(context, AppRouter.CART),
          counter: 0,
          size: 30,
        );
      },
    );
  }
}
