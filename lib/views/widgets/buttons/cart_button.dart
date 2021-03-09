import 'package:e_commerce_app/business_logic/blocs/cart/bloc.dart';
import 'package:e_commerce_app/configs/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'icon_button_with_counter.dart';

class CartButton extends StatelessWidget {
  final Color color;

  const CartButton({Key? key, this.color = Colors.white}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
        buildWhen: (prevState, currState) => currState is CartLoaded,
        builder: (context, state) {
          return IconButtonWithCounter(
            icon: Icons.shopping_bag_outlined,
            onPressed: () => Navigator.pushNamed(context, AppRouter.CART),
            counter: state is CartLoaded ? state.cart.length : 0,
            size: 30,
            color: color,
          );
        });
  }
}
