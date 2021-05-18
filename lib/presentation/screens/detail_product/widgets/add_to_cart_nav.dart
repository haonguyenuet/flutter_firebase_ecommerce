import 'package:e_commerce_app/presentation/common_blocs/cart/bloc.dart';
import 'package:e_commerce_app/data/models/models.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  void onDecreaseQuantity() => setState(() => quantity -= 1);
  void onIncreaseQuantity() => setState(() => quantity += 1);

  void onAddToCart() {
    // Create new cart item
    CartItemModel cartItem = CartItemModel(
      id: product.id,
      productId: product.id,
      price: product.price * quantity,
      quantity: quantity,
    );
    // Add event AddToCart
    BlocProvider.of<CartBloc>(context).add(AddCartItemModel(cartItem));
    // Show toast: add successfully
    UtilToast.showMessageForUser(context, "Add successfully");
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
            child: InkWell(
              onTap: onDecreaseQuantity,
              child: Icon(Icons.remove, color: COLOR_CONST.primaryColor),
            ),
          ),
        ),

        /// Display the quantity of product
        Text("$quantity", style: FONT_CONST.BOLD_PRIMARY_18),

        /// Button increases the quantity of product
        AspectRatio(
          aspectRatio: 1,
          child: AbsorbPointer(
            absorbing: quantity < product.quantity ? false : true,
            child: InkWell(
              onTap: onIncreaseQuantity,
              child: Icon(Icons.add, color: COLOR_CONST.primaryColor),
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
      color: COLOR_CONST.primaryColor,
      child: TextButton(
        onPressed: product.quantity > 0 ? onAddToCart : null,
        child: SvgPicture.asset(
          ICON_CONST.ADD_TO_CART,
          width: SizeConfig.defaultSize * 3,
          color: Colors.white,
        ),
      ),
    );
  }
}
