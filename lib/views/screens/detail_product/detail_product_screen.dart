import 'package:e_commerce_app/business_logic/entities/product.dart';
import 'package:e_commerce_app/views/screens/detail_product/widgets/body.dart';
import 'package:e_commerce_app/views/screens/detail_product/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'widgets/add_to_cart_nav.dart';

class DetailProductScreen extends StatelessWidget {
  static String routeName = "/detail_procduct";

  @override
  Widget build(BuildContext context) {
    final DetailProductArgument arguments =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: CustomAppBar(product: arguments.product),
      body: Body(product: arguments.product),
      bottomNavigationBar: AddToCartNavigation(product: arguments.product),
    );
  }
}

// We also need to pass our product to our detail product screen
// Because we use name route so we need to create a arguments class

class DetailProductArgument {
  final Product product;

  DetailProductArgument({@required this.product});
}
