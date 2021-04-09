import 'package:e_commerce_app/business_logic/entities/category.dart';
import 'package:e_commerce_app/configs/config.dart';
import 'package:e_commerce_app/presentation/screens/categories/bloc/bloc.dart';
import 'package:e_commerce_app/presentation/screens/categories/widgets/product_gallery.dart';
import 'package:e_commerce_app/presentation/screens/categories/widgets/toolbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  final Category category;

  const CategoriesScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoriesBloc>(
      create: (context) => CategoriesBloc()..add(OpenScreen(category)),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              ToolBarWidget(currCategory: category),
              Expanded(child: ProductGallery()),
            ],
          ),
        ),
      ),
    );
  }
}