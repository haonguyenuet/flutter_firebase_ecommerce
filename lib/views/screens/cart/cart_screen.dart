import 'package:e_commerce_app/business_logic/repository/repository.dart';
import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:e_commerce_app/views/screens/cart/bloc/bloc.dart';
import 'package:e_commerce_app/views/screens/cart/widgets/body.dart';
import 'package:e_commerce_app/views/screens/cart/widgets/check_out_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc(
        cartRepository: RepositoryProvider.of<CartRepository>(context),
        userRepository: RepositoryProvider.of<UserRepository>(context),
      )..add(LoadCart()),
      child: Scaffold(
        appBar: buildAppBar(context),
        body: Body(),
        bottomNavigationBar: CheckoutCard(),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text("Your cart"),
      actions: [
        IconButton(
          icon: Icon(Icons.clear_all_rounded, color: mAccentTintColor),
          tooltip: "Clear all",
          onPressed: () {},
        )
      ],
    );
  }
}
