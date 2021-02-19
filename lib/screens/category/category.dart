import 'package:e_commerce_app/models/category.dart';
import 'package:e_commerce_app/providers/category_filter.dart';
import 'package:e_commerce_app/screens/category/components/body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  static String routeName = "/category";
  @override
  Widget build(BuildContext context) {
    // get arguments
    CategoryArgument arguments = ModalRoute.of(context).settings.arguments;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CategoryFilterProvider(arguments.category),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Body(),
      ),
    );
  }
}

class CategoryArgument {
  final Category category;

  CategoryArgument({@required this.category});
}
