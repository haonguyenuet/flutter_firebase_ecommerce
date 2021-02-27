import 'package:e_commerce_app/views/screens/cart/bloc/cart_bloc.dart';
import 'package:e_commerce_app/views/screens/cart/bloc/cart_event.dart';
import 'package:e_commerce_app/views/screens/cart/bloc/cart_state.dart';
import 'package:e_commerce_app/views/screens/cart/widgets/cart_item_card.dart';
import 'package:e_commerce_app/views/widgets/others/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return Loading();
        }

        if (state is CartLoadFailure) {
          return Center(child: Text("Load failure"));
        }
        if (state is CartLoaded) {
          var cart = state.cartResponse.cart;
          return SafeArea(
            child: cart.length > 0
                ? ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: Key(cart[index].pid),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          // Remove this item from the cart
                          BlocProvider.of<CartBloc>(context)
                              .add(RemoveCartItem(cart[index].pid));
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
                    child: Text("Bạn chưa có sản phẩm nào trong giỏ hàng")),
          );
        }
        return Center(child: Text("Something went wrong."));
      },
    );
  }
}
