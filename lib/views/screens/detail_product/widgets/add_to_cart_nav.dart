import 'package:e_commerce_app/business_logic/entities/cart_item.dart';
import 'package:e_commerce_app/business_logic/entities/product.dart';
import 'package:e_commerce_app/views/screens/cart/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/constants/color_constant.dart';

/// Class
class AddToCartNavigation extends StatefulWidget {
  final Product product;
  const AddToCartNavigation({
    Key key,
    @required this.product,
  }) : super(key: key);

  @override
  _AddToCartNavigationState createState() => _AddToCartNavigationState();
}

class _AddToCartNavigationState extends State<AddToCartNavigation> {
  Product get product => widget.product;
  // init states
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(offset: Offset(0.15, 0.4), color: Colors.black)],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(flex: 1, child: buildSelectQuantity()),
            Expanded(flex: 1, child: addToCartButton()),
          ],
        ),
      ),
    );
  }

  Row buildSelectQuantity() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Button decreases the quantity of product
        Container(
          height: 60,
          width: 60,
          child: AbsorbPointer(
            absorbing: quantity > 1 ? false : true,
            child: RaisedButton(
              onPressed: () {
                setState(() {
                  quantity -= 1;
                });
              },
              color: Colors.white,
              child: Icon(Icons.remove, color: mPrimaryColor),
            ),
          ),
        ),

        /// Display the quantity of product
        Text(
          "$quantity",
          style: TextStyle(
            color: mPrimaryColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),

        /// Button increases the quantity of product
        Container(
          height: 60,
          width: 60,
          child: AbsorbPointer(
            absorbing: quantity < product.quantity ? false : true,
            child: RaisedButton(
              onPressed: () {
                setState(() {
                  quantity += 1;
                });
              },
              color: Colors.white,
              child: Icon(Icons.add, color: mPrimaryColor),
            ),
          ),
        ),
      ],
    );
  }

  /// Build button add to cart
  Container addToCartButton() {
    return Container(
      height: 60,
      child: RaisedButton(
        onPressed: product.quantity > 0
            ? () {
                // create new cart item
                CartItem cartItem = CartItem(
                  cid: product.id,
                  pid: product.id,
                  price: product.originalPrice * quantity,
                  quantity: quantity,
                );

                // go to cart screen
                Navigator.pushNamed(context, CartScreen.routeName);
              }
            : null,
        color: mPrimaryColor,
        child: Icon(Icons.add_shopping_cart, color: Colors.white),
      ),
    );
  }
}
