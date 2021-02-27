import 'package:e_commerce_app/business_logic/entities/category.dart';
import 'package:e_commerce_app/business_logic/repository/repository.dart';
import 'package:e_commerce_app/views/screens/all_products/bloc/bloc.dart';
import 'package:e_commerce_app/views/screens/all_products/widgets/categories.dart';
import 'package:e_commerce_app/views/screens/all_products/widgets/list_products.dart';
import 'package:e_commerce_app/views/screens/all_products/widgets/toolbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllProductsScreen extends StatefulWidget {
  final Category category;

  const AllProductsScreen({
    Key key,
    this.category,
  }) : super(key: key);
  @override
  _AllProductsScreenState createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  Category get category => widget.category;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AllProductsBloc>(
      create: (context) => AllProductsBloc(
        productRepository: RepositoryProvider.of<ProductRepository>(context),
      )..add(OpenScreen(category)),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            child: Column(
              children: <Widget>[
                ToolBar(),
                Categories(),
                Expanded(child: ListProducts()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}