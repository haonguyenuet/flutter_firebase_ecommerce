import 'package:e_commerce_app/business_logic/entities/entites.dart';
import 'package:e_commerce_app/configs/router.dart';
import 'package:e_commerce_app/views/screens/home_page/bloc/bloc.dart';
import 'package:e_commerce_app/views/screens/home_page/widgets/home_banner.dart';
import 'package:e_commerce_app/views/widgets/custom_widgets.dart';
import 'package:e_commerce_app/views/widgets/others/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, homeState) {
          if (homeState is HomeLoaded) {
            var homeResponse = homeState.homeResponse;
            return SingleChildScrollView(
              child: Column(
                children: [
                  HomeBanner(banners: homeResponse.banners),
                  _buildHomeCategories(context, homeResponse.categories),
                  _buildPopularProducts(context, homeResponse.popularProducts),
                  _buildDiscountProducts(
                      context, homeResponse.discountProducts),
                ],
              ),
            );
          }
          if (homeState is HomeLoading) {
            return Loading();
          }
          if (homeState is HomeLoadFailure) {
            return Center(child: Text(homeState.error));
          }
          return Center(child: Text("Something went wrong."));
        },
      ),
    );
  }

  _buildPopularProducts(BuildContext context, List<Product> popularProducts) {
    return Section(
      title: "Popular products",
      children: popularProducts.map((p) => ProductCard(product: p)).toList(),
      handleOnSeeAll: () => navigatorToAllProducts(context),
    );
  }

  _buildDiscountProducts(BuildContext context, List<Product> discountProducts) {
    return Section(
      title: "Discount products",
      children: discountProducts.map((p) => ProductCard(product: p)).toList(),
      handleOnSeeAll: () => navigatorToAllProducts(context),
    );
  }

  _buildHomeCategories(BuildContext context, List<Category> categories) {
    return Section(
      title: "Product Categories",
      children: categories
          .map((c) => CategoryCard(
              category: c,
              onPressed: () => navigatorToAllProducts(context, category: c)))
          .toList(),
      handleOnSeeAll: () => navigatorToAllProducts(context),
    );
  }

  void navigatorToAllProducts(BuildContext context, {Category? category}) {
    Navigator.pushNamed(context, AppRouter.ALL_PRODUCTS, arguments: category);
  }
}
