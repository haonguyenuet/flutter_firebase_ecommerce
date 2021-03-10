import 'package:e_commerce_app/business_logic/blocs/cart/bloc.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/views/widgets/others/loading.dart';
import 'package:e_commerce_app/views/widgets/single_card/cart_item_card.dart';
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
                      return Dismissible(
                        key: Key(cart[index].id),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          // Remove this item from the cart
                          BlocProvider.of<CartBloc>(context)
                              .add(RemoveCartItem(cart[index]));
                        },
                        background: Container(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          decoration: BoxDecoration(color: Color(0xFFFFE6E6)),
                          child: Row(
                            children: [
                              Spacer(),
                              Icon(Icons.remove_shopping_cart_outlined),
                            ],
                          ),
                        ),
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
}
