import 'package:e_commerce_app/views/screens/cart/widgets/cart_body.dart';
import 'package:e_commerce_app/views/screens/cart/widgets/check_out_card.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/business_logic/blocs/cart/bloc.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: CartBody(),
      bottomNavigationBar: CheckoutCard(),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text("Your cart"),
      actions: [
        IconButton(
          icon: Icon(Icons.clear_all_rounded, color: mAccentTintColor),
          tooltip: "Clear all",
          onPressed: () async {
            bool response = await MyDialog.showConfirmation(
              context,
              content: "All cart items will be deleted from your cart",
              confirmButtonText: "Delete",
            );
            if (response) {
              BlocProvider.of<CartBloc>(context).add(ClearCart());
            }
          },
        )
      ],
    );
  }
}
