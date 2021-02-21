import 'package:e_commerce_app/providers/cart_provider.dart';
import 'package:e_commerce_app/screens/cart/components/cart_item_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartProvider>().cart;
    return SafeArea(
      child: cart.length > 0
          ? ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(cart[index].pid),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    // remove this item from the cart
                    context.read<CartProvider>().removeItem(cart[index].cid);
                  },
                  background: Container(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFE6E6),
                      borderRadius: BorderRadius.circular(10),
                    ),
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
          : Center(child: Text("Bạn chưa có sản phẩm nào trong giỏ hàng")),
    );
  }
}
