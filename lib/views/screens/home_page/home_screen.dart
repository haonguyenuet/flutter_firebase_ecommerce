import 'package:e_commerce_app/business_logic/entities/entites.dart';
import 'package:e_commerce_app/configs/router.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/views/screens/home_page/bloc/bloc.dart';
import 'package:e_commerce_app/views/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/views/screens/home_page/widgets/home_banner.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/app_bar.dart';
import 'package:e_commerce_app/views/screens/home_page/widgets/special_offers.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(LoadHome());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: buildAppBar(context),
          body: SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: _buildContent(state),
            ),
          ),
          bottomNavigationBar: CustomBottomNav(selectedMenu: MenuState.home),
        );
      },
    );
  }

  Widget _buildContent(HomeState homeState) {
    if (homeState is HomeLoaded) {
      List<BannerItem> banners = homeState.homeResponse.banners ?? [];
      List<Category> categories = homeState.homeResponse.categories ?? [];
      List<Product> products = homeState.homeResponse.products ?? [];
      return SingleChildScrollView(
        child: Column(
          children: [
            HomeBanner(banners: banners),
            _buildHomeCategories(categories),
            _buildPopularProducts(products),
            SpecialOffers(),
          ],
        ),
      );
    }
    if (homeState is HomeLoading) {
      return Center(child: CircularProgressIndicator());
    }
    if (homeState is HomeLoadFailure) {
      return Center(child: Text(homeState.error));
    }
    return Center(child: Text("Something went wrong."));
  }

  Section _buildPopularProducts(List<Product> products) {
    return Section(
      title: "Popular product",
      children: products.map((p) => ProductCard(product: p)).toList(),
      handleOnTap: () => navigatorToAllProducts(context),
    );
  }

  Section _buildHomeCategories(List<Category> categories) {
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

  void navigatorToAllProducts(BuildContext context, {Category category}) {
    Navigator.pushNamed(context, AppRouter.ALL_PRODUCTS, arguments: category);
  }
}
