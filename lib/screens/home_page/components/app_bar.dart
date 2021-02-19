import 'package:e_commerce_app/components/cart_button.dart';
import 'package:e_commerce_app/providers/cart_provider.dart';
import 'package:e_commerce_app/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

import 'package:e_commerce_app/common/common_func.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/screens/detail_product/detail_product_screen.dart';

AppBar buildAppBar(BuildContext context) {
  var cart = context.watch<CartProvider>().cart;
  return AppBar(
    automaticallyImplyLeading: false,
    title: Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        "Peachy",
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: mPrimaryColor,
        ),
      ),
    ),
    actions: [
      /// Icon search
      IconButton(
        icon: SvgPicture.asset("assets/icons/Search Icon.svg"),
        onPressed: () => showSearch(context: context, delegate: SearchData()),
      ),

      /// Icon Cart
      CartButton(counter: cart.length),
      SizedBox(width: 10),
    ],
  );
}

/// Class provides function search product
class SearchData extends SearchDelegate<Product> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Product> products = context.watch<ProductProvider>().products;
    var suggestions = products
        .where((p) => p.name.toLowerCase().startsWith(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: suggestions.length > 10 ? 10 : suggestions.length,
      itemBuilder: (context, index) {
        var product = suggestions[index];
        return buildSuggestionItem(context, product);
      },
    );
  }

  ListTile buildSuggestionItem(BuildContext context, Product product) {
    return ListTile(
      onTap: () => Navigator.pushReplacementNamed(
        context,
        DetailProductScreen.routeName,
        arguments: DetailProductArgument(product: product),
      ),
      leading: FutureBuilder(
        future: getProductImage(imageURL: product.images[0]),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Image.network(snapshot.data)
              : CircularProgressIndicator();
        },
      ),
      title: Text.rich(
        TextSpan(
          style: TextStyle(color: mSecondaryColor),
          children: [
            TextSpan(
                text: product.name.substring(0, query.length),
                style: TextStyle(color: Colors.black)),
            TextSpan(text: product.name.substring(query.length))
          ],
        ),
      ),
      subtitle: Text(
        "${formatNumber(product.originalPrice)} VNĐ",
        style: TextStyle(color: mPrimaryColor),
      ),
    );
  }
}
