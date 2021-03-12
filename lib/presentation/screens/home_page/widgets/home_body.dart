import 'package:e_commerce_app/business_logic/entities/entites.dart';
import 'package:e_commerce_app/configs/router.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/presentation/screens/home_page/bloc/bloc.dart';
import 'package:e_commerce_app/presentation/screens/home_page/widgets/home_banner.dart';
import 'package:e_commerce_app/presentation/widgets/custom_widgets.dart';
import 'package:e_commerce_app/presentation/widgets/others/loading.dart';
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
    return SectionWidget(
      title: "Popular products",
      children: popularProducts.map((p) => ProductCard(product: p)).toList(),
      handleOnSeeAll: () => navigatorToAllProducts(context),
    );
  }

  _buildDiscountProducts(BuildContext context, List<Product> discountProducts) {
    return SectionWidget(
      title: "Discount products",
      children: discountProducts.map((p) => ProductCard(product: p)).toList(),
      handleOnSeeAll: () => navigatorToAllProducts(context),
    );
  }

  _buildHomeCategories(BuildContext context, List<Category> categories) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SectionTitle(
          title: "Product Categories",
          handleOnSeeAll: () => navigatorToAllProducts(context),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 1.5),
          child: GridView.builder(
            itemCount: categories.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: SizeConfig.defaultSize,
              crossAxisSpacing: SizeConfig.defaultSize,
              childAspectRatio: 931 / 485,
            ),
            itemBuilder: (context, index) {
              return CategoryCard(
                category: categories[index],
                onPressed: () => navigatorToAllProducts(context,
                    category: categories[index]),
              );
            },
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          ),
        ),
      ],
    );
  }

  void navigatorToAllProducts(BuildContext context, {Category? category}) {
    Navigator.pushNamed(context, AppRouter.ALL_PRODUCTS, arguments: category);
  }
}
