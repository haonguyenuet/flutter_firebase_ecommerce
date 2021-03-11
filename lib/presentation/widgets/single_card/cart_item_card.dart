import 'package:e_commerce_app/business_logic/blocs/cart/bloc.dart';
import 'package:e_commerce_app/business_logic/repository/product_repository/firebase_product_repo.dart';
import 'package:e_commerce_app/configs/router.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/utils/my_formatter.dart';

import 'package:e_commerce_app/presentation/widgets/buttons/circle_icon_button.dart';
import 'package:e_commerce_app/business_logic/entities/cart_item.dart';
import 'package:e_commerce_app/business_logic/entities/product.dart';
import 'package:e_commerce_app/presentation/widgets/custom_widgets.dart';
import 'package:e_commerce_app/presentation/widgets/others/custom_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    Key? key,
    required this.cartItem,
    this.allowChangeQuantity = true,
  }) : super(key: key);

  final CartItem cartItem;
  final bool allowChangeQuantity;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseProductRepository().getProductById(cartItem.productId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var product = snapshot.data as Product;
          return CustomCardWidget(
            onTap: () => Navigator.pushNamed(
              context,
              AppRouter.DETAIL_PRODUCT,
              arguments: product,
            ),
            margin: EdgeInsets.symmetric(
              vertical: SizeConfig.defaultSize * 0.5,
              horizontal: SizeConfig.defaultSize,
            ),
            child: Row(
              children: [
                _buildCartItemImage(product),
                SizedBox(width: SizeConfig.defaultSize),
                Expanded(child: _buildCartItemInfo(product, context)),
              ],
            ),
          );
        }

        return Container();
      },
    );
  }

  _buildCartItemImage(Product product) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.defaultSize * 0.5),
      child: ShimmerImage(
        imageUrl: product.images[0],
        height: SizeConfig.defaultSize * 13,
      ),
    );
  }

  _buildCartItemInfo(Product product, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Product Name
        Text(
          "${product.name}",
          style: FONT_CONST.MEDIUM_DEFAULT_16,
          maxLines: 1,
        ),

        // Cart item price
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Text(
            "${formatNumber(product.price)} ₫",
            style: FONT_CONST.REGULAR_PRIMARY_18,
          ),
        ),

        allowChangeQuantity
            ? _buildCartItemQuantity(product, context)
            : Text("x ${cartItem.quantity}")
      ],
    );
  }

  _buildCartItemQuantity(Product product, BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Decrease button
        CircleIconButton(
          svgIcon: "assets/icons/subtract.svg",
          color: Color(0xFFF5F6F9),
          size: SizeConfig.defaultSize * 1.2,
          onPressed: cartItem.quantity > 1
              ? () => _changeQuantity(context, product, cartItem.quantity - 1)
              : () {},
        ),

        // Quantity
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize),
          child: Text("${cartItem.quantity}", style: FONT_CONST.BOLD_PRIMARY),
        ),

        // Increase button
        CircleIconButton(
          svgIcon: "assets/icons/add.svg",
          color: Color(0xFFF5F6F9),
          size: SizeConfig.defaultSize * 1.2,
          onPressed: cartItem.quantity < product.quantity
              ? () => _changeQuantity(context, product, cartItem.quantity + 1)
              : () {},
        )
      ],
    );
  }

  _changeQuantity(BuildContext context, Product product, int newQuantity) {
    // update cart item
    BlocProvider.of<CartBloc>(context).add(UpdateCartItem(
      cartItem.cloneWith(
        quantity: newQuantity,
        price: newQuantity * product.price,
      ),
    ));
  }
}
