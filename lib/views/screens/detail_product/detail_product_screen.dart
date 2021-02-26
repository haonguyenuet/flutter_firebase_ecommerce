import 'package:e_commerce_app/business_logic/entities/product.dart';
import 'package:e_commerce_app/business_logic/repositories/detail_product_repo.dart';
import 'package:e_commerce_app/business_logic/repositories/user_repo.dart';
import 'package:e_commerce_app/configs/router.dart';
import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:e_commerce_app/utils/common_func.dart';
import 'package:e_commerce_app/views/screens/detail_product/bloc/detail_product_bloc.dart';
import 'package:e_commerce_app/views/screens/detail_product/bloc/detail_product_state.dart';
import 'package:e_commerce_app/views/screens/detail_product/widgets/custom_appbar.dart';
import 'package:e_commerce_app/views/screens/detail_product/widgets/product_images.dart';
import 'package:e_commerce_app/views/screens/detail_product/widgets/product_info.dart';
import 'package:e_commerce_app/views/screens/detail_product/widgets/related_products/bloc/related_products_bloc.dart';
import 'package:e_commerce_app/views/screens/detail_product/widgets/related_products/bloc/related_products_event.dart';
import 'package:e_commerce_app/views/screens/detail_product/widgets/related_products/related_products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'widgets/add_to_cart_nav.dart';

class DetailProductScreen extends StatelessWidget {
  final _detailProductRepository = DetailProductRepository();
  final Product product;

  DetailProductScreen({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DetailProductBloc(
                detailProductRepository: _detailProductRepository,
                userRepository: RepositoryProvider.of<UserRepository>(context)),
          ),
          BlocProvider(
            create: (context) => RelatedProductsBloc(
              detailProductRepository: _detailProductRepository,
            )..add(LoadRelatedProducts(product.id, product.categoryId)),
          ),
        ],
        child: BlocListener<DetailProductBloc, DetailProductState>(
          listener: (context, state) {
            if (state is Adding) {
              showCenterLoadingDialog(context);
            }
            if (state is AddSuccess) {
              Navigator.pop(context); //pop loading dialog
              Navigator.pushNamed(context, AppRouter.CART);
            }
            if (state is AddFailure) {
              showFailureDialog(context, "Add Failure");
            }
          },
          child: Scaffold(
            appBar: CustomAppBar(product: product),
            body: SafeArea(
              child: ListView(
                children: [
                  SizedBox(height: 20),
                  ProductImages(product: product),
                  SizedBox(height: 10),
                  ProductInfo(product: product),
                  RelatedProducts(),
                ],
              ),
            ),
            bottomNavigationBar: AddToCartNavigation(product: product),
          ),
        ));
  }
}

/// Show Center Loading Dialog
void showCenterLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        content: SpinKitCircle(color: mPrimaryColor),
      );
    },
  );
}
