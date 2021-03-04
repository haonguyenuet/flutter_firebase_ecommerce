import 'package:e_commerce_app/business_logic/entities/entites.dart';
import 'package:e_commerce_app/configs/router.dart';
import 'package:e_commerce_app/views/screens/home_page/bloc/bloc.dart';
import 'package:e_commerce_app/views/screens/home_page/widgets/home_banner.dart';
import 'package:e_commerce_app/views/screens/home_page/widgets/special_offers.dart';
import 'package:e_commerce_app/views/widgets/custom_widgets.dart';
import 'package:e_commerce_app/views/widgets/others/loading.dart';
import 'package:e_commerce_app/views/widgets/single_card/category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, homeState) {
          if (homeState is HomeLoaded) {
            List<BannerItem> banners = homeState.homeResponse.banners ?? [];
            List<Category> categories = homeState.homeResponse.categories ?? [];
            List<Product> products = homeState.homeResponse.products ?? [];
            return SingleChildScrollView(
              child: Column(
                children: [
                  HomeBanner(banners: banners),
                  _buildHomeCategories(context, categories),
                  _buildPopularProducts(context, products),
                  SpecialOffers(),
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

  _buildPopularProducts(BuildContext context, List<Product> products) {
    return Section(
      title: "Popular product",
      children: products.map((p) => ProductCard(product: p)).toList(),
      handleOnTap: () => navigatorToAllProducts(context),
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
      handleOnTap: () => navigatorToAllProducts(context),
    );
  }

  void navigatorToAllProducts(BuildContext context, {Category? category}) {
    Navigator.pushNamed(context, AppRouter.ALL_PRODUCTS, arguments: category);
  }
}
