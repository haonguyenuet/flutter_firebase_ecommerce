import 'package:e_commerce_app/business_logic/blocs/cart/bloc.dart';
import 'package:e_commerce_app/views/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          var cart = state.cart;
          return ListView.builder(
            itemCount: cart.length,
            itemBuilder: (context, index) {
              return CartItemCard(
                cartItem: cart[index],
                allowChangeQuantity: false,
              );
            },
          );
        }
        if (state is CartLoadFailure) {
          return Center(child: Text("Load failure"));
        }
        return Center(child: Text("Something went wrong."));
      },
    );
  }
}
