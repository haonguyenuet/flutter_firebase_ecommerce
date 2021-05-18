import 'package:e_commerce_app/presentation/common_blocs/cart/bloc.dart';
import 'package:e_commerce_app/data/models/models.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/image_constant.dart';
import 'package:e_commerce_app/presentation/widgets/others/custom_dismissible.dart';
import 'package:e_commerce_app/presentation/widgets/others/loading.dart';
import 'package:e_commerce_app/presentation/widgets/others/promo_widget.dart';
import 'package:e_commerce_app/presentation/widgets/single_card/cart_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListCartItemModel extends StatelessWidget {
  void _onDismissed(BuildContext context, CartItemModel cartItem) {
    BlocProvider.of<CartBloc>(context).add(RemoveCartItemModel(cartItem));
  }

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
                    physics: BouncingScrollPhysics(),
                    itemCount: cart.length + 1,
                    itemBuilder: (context, index) {
                      if (index == cart.length) {
                        return PromoWidget();
                      }
                      return CustomDismissible(
                        key: Key(cart[index].id),
                        onDismissed: (direction) {
                          _onDismissed(context, cart[index]);
                        },
                        removeIcon: Icon(Icons.remove_shopping_cart),
                        child: CartItemModelCard(cartItem: cart[index]),
                      );
                    },
                  )
                : Center(
                    child: Image.asset(
                    IMAGE_CONST.CART_EMPTY,
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
