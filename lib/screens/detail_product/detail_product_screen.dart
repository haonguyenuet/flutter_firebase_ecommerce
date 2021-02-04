import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/screens/detail_product/components/body.dart';
import 'package:flutter/material.dart';
import 'components/add_to_cart_nav.dart';
import 'components/custom_appbar.dart';

class DetailProductScreen extends StatelessWidget {
  static String routeName = "/detail_procduct";

  @override
  Widget build(BuildContext context) {
    final DetailProductArgument arguments =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: CustomAppBar(rating: arguments.product.rating),
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
