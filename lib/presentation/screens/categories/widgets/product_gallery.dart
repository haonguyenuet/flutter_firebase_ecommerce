import 'package:e_commerce_app/configs/config.dart';
import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/presentation/screens/categories/bloc/bloc.dart';
import 'package:e_commerce_app/presentation/screens/categories/widgets/grid_products.dart';
import 'package:e_commerce_app/presentation/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductGallery extends StatefulWidget {
  @override
  _ProductGalleryState createState() => _ProductGalleryState();
}

class _ProductGalleryState extends State<ProductGallery>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int currentTabIndex = 0;

  @override
  void initState() {
    tabController = TabController(
      length: 3,
      vsync: this,
    );

    tabController.addListener(() {
      setState(() {
        currentTabIndex = tabController.index;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      buildWhen: (preState, currState) => currState is DisplayListProducts,
      builder: (context, state) {
        if (state is DisplayListProducts) {
          if (state.loading) {
            return Loading();
          }
          if (state.msg.isNotEmpty) {
            return Center(child: Text(state.msg));
          }
          if (state.priceSegment != null) {
            var priceSegment = state.priceSegment!;
            return Column(
              children: <Widget>[
                _buildTabs(),
                SizedBox(height: SizeConfig.defaultSize),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: <Widget>[
                      GridProducts(products: priceSegment.productsInLowRange),
                      GridProducts(products: priceSegment.productsInMidRange),
                      GridProducts(products: priceSegment.productsInHighRange)
                    ],
                  ),
                )
              ],
            );
          }
          return Center(child: Text("Something went wrong."));
        } else {
          return Center(child: Text("Something went wrong."));
        }
      },
    );
  }

  _buildTabs() {
    return DefaultTabController(
      length: 3,
      child: TabBar(
        controller: tabController,
        tabs: <Widget>[
          Tab(text: '< 1 triệu đồng'),
          Tab(text: ' 1 - 4 triệu đồng'),
          Tab(text: '> 4 triệu đồng'),
        ],
        onTap: (index) {},
        labelStyle: FONT_CONST.BOLD_PRIMARY_18,
        labelColor: COLOR_CONST.textColor,
        unselectedLabelColor: COLOR_CONST.textColor,
        unselectedLabelStyle: FONT_CONST.BOLD_DEFAULT,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: COLOR_CONST.primaryColor,
        indicatorWeight: 2,
      ),
    );
  }
}
