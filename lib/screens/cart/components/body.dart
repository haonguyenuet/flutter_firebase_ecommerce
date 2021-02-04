import 'package:e_commerce_app/screens/cart/components/cart_item_card.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/models/cart.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  final Map<String, CartItem> cart;

  const Body({Key key, this.cart}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.only(bottom: 10),
      child: cart.length > 0
          ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      String key = cart.keys.elementAt(index);
                      return Dismissible(
                        key: Key(key),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          context.read<Cart>().removeItem(key);
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
                              SvgPicture.asset("assets/icons/Trash.svg"),
                            ],
                          ),
                        ),
                        child: CartItemCard(cartItem: cart[key]),
                      );
                    },
                  ),
                ),
              ],
            )
          : Center(
              child: Text("Bạn chưa có sản phẩm nào trong giỏ hàng"),
            ),
    );
  }
}
