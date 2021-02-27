import 'package:e_commerce_app/business_logic/entities/category.dart';
import 'package:e_commerce_app/business_logic/repository/repository.dart';
import 'package:e_commerce_app/views/screens/all_products/bloc/bloc.dart';
import 'package:e_commerce_app/views/screens/all_products/widgets/categories.dart';
import 'package:e_commerce_app/views/screens/all_products/widgets/list_products.dart';
import 'package:e_commerce_app/views/screens/all_products/widgets/toolbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllProductsScreen extends StatelessWidget {
  final Category category;

  const AllProductsScreen({
    Key key,
    this.category,
  }) : super(key: key);

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
                _buildMyAppBar(),
                Expanded(child: ListProducts()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildMyAppBar() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 5,
            color: Colors.black12,
          ),
        ],
      ),
      child: Column(
        children: [
          ToolBar(),
          Categories(),
        ],
      ),
    );
  }
}
