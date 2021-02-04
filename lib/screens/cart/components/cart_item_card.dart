import 'package:e_commerce_app/common/common_func.dart';
import 'package:e_commerce_app/models/cart.dart';
import 'package:flutter/material.dart';

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
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        height: getProportionateScreenHeight(130),
        decoration: BoxDecoration(
          color: Color(0xFFF5F6F9),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            /// CartItem image
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: FutureBuilder(
                  future: getProductImage(product: cartItem.product, index: 0),
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? Image.network(snapshot.data)
                        : CircularProgressIndicator();
                  },
                ),
              ),
            ),
            SizedBox(width: getProportionateScreenWidth(10)),

            /// CartItem Info
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${cartItem.product.name}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text.rich(
                    TextSpan(
                      text: "${formatNumber(cartItem.product.price)} VNĐ",
                      style: TextStyle(color: mPrimaryColor, fontSize: 17),
                      children: [
                        TextSpan(
                          text: " x ${cartItem.numberOfItems}",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
