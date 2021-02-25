import 'package:e_commerce_app/views/widgets/buttons/cart_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'package:e_commerce_app/constants/color_constant.dart';

AppBar buildAppBar(BuildContext context) {
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
        onPressed: () => {}
      ),

      /// Icon Cart
      CartButton(counter: 8),
      SizedBox(width: 10),
    ],
  );
}

// /// Class provides function search product
// class SearchData extends SearchDelegate<Product> {
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//           icon: Icon(Icons.clear),
//           onPressed: () {
//             query = "";
//           }),
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: AnimatedIcon(
//         icon: AnimatedIcons.menu_arrow,
//         progress: transitionAnimation,
//       ),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     // TODO: implement buildResults
//     throw UnimplementedError();
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     List<Product> products = context.watch<ProductProvider>().products;
//     var suggestions = products
//         .where((p) => p.name.toLowerCase().startsWith(query.toLowerCase()))
//         .toList();
//     return ListView.builder(
//       itemCount: suggestions.length > 10 ? 10 : suggestions.length,
//       itemBuilder: (context, index) {
//         var product = suggestions[index];
//         return buildSuggestionItem(context, product);
//       },
//     );
//   }

//   ListTile buildSuggestionItem(BuildContext context, Product product) {
//     return ListTile(
//       onTap: () => Navigator.pushReplacementNamed(
//         context,
//         DetailProductScreen.routeName,
//         arguments: DetailProductArgument(product: product),
//       ),
//       leading: FutureBuilder(
//         future: loadImage(product.images[0]),
//         builder: (context, snapshot) {
//           return snapshot.hasData
//               ? Image.network(snapshot.data)
//               : CircularProgressIndicator();
//         },
//       ),
//       title: Text.rich(
//         TextSpan(
//           style: TextStyle(color: mSecondaryColor),
//           children: [
//             TextSpan(
//                 text: product.name.substring(0, query.length),
//                 style: TextStyle(color: Colors.black)),
//             TextSpan(text: product.name.substring(query.length))
//           ],
//         ),
//       ),
//       subtitle: Text(
//         "${formatNumber(product.originalPrice)} VNĐ",
//         style: TextStyle(color: mPrimaryColor),
//       ),
//     );
//   }
// }
