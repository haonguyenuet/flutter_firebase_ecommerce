import 'package:e_commerce_app/common/common_func.dart';
import 'package:e_commerce_app/components/circle_icon_button.dart';
import 'package:e_commerce_app/models/cart_item.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/providers/cart_provider.dart';
import 'package:e_commerce_app/providers/product_provider.dart';
import 'package:e_commerce_app/screens/detail_product/detail_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    Key key,
    this.cartItem,
  }) : super(key: key);

  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.watch<ProductProvider>().getProductById(cartItem.pid),
      builder: (context, snapshot) {
        Product product = snapshot.data;
        return snapshot.hasData
            ? GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    DetailProductScreen.routeName,
                    arguments: DetailProductArgument(product: product),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: getProportionateScreenHeight(130),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(3, 4),
                        blurRadius: 10,
                        color: Color(0XFFB0CCE1).withOpacity(0.4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      _buildCartItemImage(product),
                      SizedBox(width: getProportionateScreenWidth(10)),
                      Expanded(
                        child: buildCartItemInfo(product, context),
                      ),
                    ],
                  ),
                ),
              )
            // Loading
            : Container(
                alignment: Alignment.center,
                height: getProportionateScreenHeight(130),
                child: SpinKitCircle(color: mPrimaryColor),
              );
      },
    );
  }

  // CartItem image
  AspectRatio _buildCartItemImage(Product product) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child: FutureBuilder(
          future: getProductImage(imageURL: product.images[0]),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? Image.network(snapshot.data)
                : SpinKitCircle(color: mPrimaryColor);
          },
        ),
      ),
    );
  }

  // CartItem Info
  Column buildCartItemInfo(Product product, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Name
        Text(
          "${product.name}",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        // Cart item price
        Text(
          "${formatNumber(product.originalPrice)} VNĐ",
          style: TextStyle(color: mPrimaryColor, fontSize: 17),
        ),
        SizedBox(height: 5),

        _buildCartItemQuantity(product, context)
      ],
    );
  }

  // Cart item quantity
  Row _buildCartItemQuantity(Product product, BuildContext context) {
    return Row(
      children: [
        // decrease button
        CircleIconButton(
          icon: Icon(Icons.remove),
          color: Color(0xFFF5F6F9).withOpacity(0.7),
          size: getProportionateScreenWidth(30),
          handleOnPress: cartItem.quantity > 1
              ? () {
                  var newQuantity = cartItem.quantity - 1;
                  var newPrice = newQuantity * product.originalPrice;
                  context.read<CartProvider>().updateCartItem(
                        cartItem.cloneWith(
                          quantity: newQuantity,
                          price: newPrice,
                        ),
                      );
                }
              : () {},
        ),
        const SizedBox(width: 10),
        // quantity
        Text(
          "${cartItem.quantity}",
          style: TextStyle(
            color: mPrimaryColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 10),
        // increase button
        CircleIconButton(
          icon: Icon(Icons.add),
          color: Color(0xFFF5F6F9).withOpacity(0.7),
          size: getProportionateScreenWidth(30),
          handleOnPress: cartItem.quantity < product.quantity
              ? () {
                  var newQuantity = cartItem.quantity + 1;
                  var newPrice = newQuantity * product.originalPrice;
                  context.read<CartProvider>().updateCartItem(
                        cartItem.cloneWith(
                          quantity: newQuantity,
                          price: newPrice,
                        ),
                      );
                }
              : () {},
        )
      ],
    );
  }
}
