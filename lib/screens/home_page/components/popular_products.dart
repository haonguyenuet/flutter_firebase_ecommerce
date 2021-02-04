import 'package:e_commerce_app/components/product_card.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/screens/home_page/components/see_more.dart';
import 'package:e_commerce_app/screens/list_products/list_products_screen.dart';
import 'package:flutter/material.dart';
import '../../../size_config.dart';
import 'package:provider/provider.dart';

class PopularProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Product> products = context.watch<List<Product>>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Text(
            "Bàn phím",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(10)),
        // Section content
        Container(
          alignment: Alignment.center,
          child: products == null
              ? CircularProgressIndicator()
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(width: 15),
                      ...List.generate(
                        5,
                        (index) => ProductCard(product: products[index]),
                      ),
                      SizedBox(width: 15),
                      SeeMore(
                        handleOnPress: () {
                          Navigator.pushNamed(
                            context,
                            ListProductsScreen.routeName,
                            arguments: ListProductsArgument(
                              typeOfProduct: "keyboard",
                            ),
                          );
                        },
                      ),
                      SizedBox(width: 15),
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}
