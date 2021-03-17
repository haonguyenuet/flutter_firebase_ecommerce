import 'package:e_commerce_app/business_logic/blocs/cart/bloc.dart';
import 'package:e_commerce_app/business_logic/entities/entites.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/presentation/widgets/others/custom_dismissible.dart';
import 'package:e_commerce_app/presentation/widgets/others/loading.dart';
import 'package:e_commerce_app/presentation/widgets/single_card/cart_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return Loading();
        }
        if (state is CartLoaded) {
          var cart = state.cart;
          return SafeArea(
            child: cart.length > 0
                ? ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      return CustomDismissible(
                        key: Key(cart[index].id),
                        onDismissed: () => _onDismissed,
                        removeIcon: Icon(Icons.remove_shopping_cart),
                        child: CartItemCard(cartItem: cart[index]),
                      );
                    },
                  )
                : Center(
                    child: Image.asset(
                    "assets/images/empty_cart.png",
                    width: SizeConfig.defaultSize * 20,
                  )),
          );
        }
        if (state is CartLoadFailure) {
          return Center(child: Text("Load failure"));
        }
        return Center(child: Text("Something went wrong."));
      },
    );
  }

  void _onDismissed(BuildContext context, CartItem cartItem) {
    BlocProvider.of<CartBloc>(context).add(RemoveCartItem(cartItem));
  }
}
