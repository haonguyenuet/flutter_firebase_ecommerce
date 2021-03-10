import 'package:e_commerce_app/business_logic/blocs/cart/bloc.dart';
import 'package:e_commerce_app/business_logic/entities/cart_item.dart';
import 'package:e_commerce_app/business_logic/entities/product.dart';
import 'package:e_commerce_app/configs/router.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToCartNavigation extends StatefulWidget {
  final Product product;
  const AddToCartNavigation({Key? key, required this.product})
      : super(key: key);

  @override
  _AddToCartNavigationState createState() => _AddToCartNavigationState();
}

class _AddToCartNavigationState extends State<AddToCartNavigation> {
  Product get product => widget.product;

  // local states
  int quantity = 1;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.defaultSize * 6,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(offset: Offset(0.15, 0.4), color: Colors.black)],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(flex: 1, child: _buildSelectQuantity()),
            Expanded(flex: 1, child: _addToCartButton()),
          ],
        ),
      ),
    );
  }

  _buildSelectQuantity() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Button decreases the quantity of product
        AspectRatio(
          aspectRatio: 1,
          child: AbsorbPointer(
            absorbing: quantity > 1 ? false : true,
            child: ElevatedButton(
              onPressed: () => setState(() => quantity -= 1),
              style: ElevatedButton.styleFrom(primary: Colors.white),
              child: Icon(Icons.remove, color: mPrimaryColor),
            ),
          ),
        ),

        /// Display the quantity of product
        Text("$quantity", style: FONT_CONST.BOLD_PRIMARY_16),

        /// Button increases the quantity of product
        AspectRatio(
          aspectRatio: 1,
          child: AbsorbPointer(
            absorbing: quantity < product.quantity ? false : true,
            child: ElevatedButton(
              onPressed: () => setState(() => quantity += 1),
              style: ElevatedButton.styleFrom(primary: Colors.white),
              child: Icon(Icons.add, color: mPrimaryColor),
            ),
          ),
        ),
      ],
    );
  }

  /// Build button add to cart
  _addToCartButton() {
    return Container(
      height: SizeConfig.defaultSize * 6,
      color: mPrimaryColor,
      child: TextButton(
        onPressed: product.quantity > 0
            ? () {
                // Create new cart item
                CartItem cartItem = CartItem(
                  id: product.id,
                  productId: product.id,
                  price: product.price * quantity,
                  quantity: quantity,
                );
                // Add event AddToCart
                BlocProvider.of<CartBloc>(context).add(AddCartItem(cartItem));
                // Go to cart screen
                Navigator.pushNamed(context, AppRouter.CART);
              }
            : null,
        child: Icon(Icons.add_shopping_cart, color: Colors.white),
      ),
    );
  }
}
