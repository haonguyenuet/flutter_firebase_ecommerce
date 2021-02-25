import 'package:e_commerce_app/views/widgets/others/custom_bottom_nav.dart';
import 'package:e_commerce_app/views/widgets/others/section.dart';
import 'package:e_commerce_app/views/widgets/single_card/category_card.dart';
import 'package:e_commerce_app/views/widgets/single_card/product_card.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/business_logic/entities/banner.dart';
import 'package:e_commerce_app/business_logic/entities/category.dart';
import 'package:e_commerce_app/business_logic/entities/product.dart';
import 'package:e_commerce_app/constants/style_constant.dart';
import 'package:e_commerce_app/views/screens/home_page/bloc/home_bloc.dart';
import 'package:e_commerce_app/views/screens/home_page/bloc/home_event.dart';
import 'package:e_commerce_app/views/screens/home_page/bloc/home_state.dart';
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
            /// Banners
            HomeBanner(banners: banners),

            /// Categories
            Section(
              title: "Product Categories",
              children:
                  categories.map((c) => CategoryCard(category: c)).toList(),
              handleOnTap: () {},
            ),

            /// Section : Popular product - products are most sold
            Section(
              title: "Popular product",
              children: products.map((p) => ProductCard(product: p)).toList(),
              handleOnTap: () {},
            ),

            /// Others
            SpecialOffers(),
          ],
        ),
      );
    } else if (homeState is HomeLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (homeState is HomeNotLoaded) {
      return Center(child: Text(homeState.error));
    } else {
      return Center(child: Text("Unknown state"));
    }
  }
}
