import 'package:e_commerce_app/screens/list_products/components/body.dart';
import 'package:flutter/material.dart';

class ListProductsScreen extends StatelessWidget {
  static String routeName = "/list_products";

  @override
  Widget build(BuildContext context) {
    final ListProductsArgument arguments =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("List products"),
        centerTitle: true,
      ),
      body: Body(typeOfProduct: arguments.typeOfProduct),
    );
  }
}

// We also need to pass our product to our detail product screen
// Because we use name route so we need to create a arguments class

class ListProductsArgument {
  final String typeOfProduct;

  ListProductsArgument({@required this.typeOfProduct});
}
