import 'package:e_commerce_app/data/models/models.dart';
import 'package:e_commerce_app/configs/router.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:e_commerce_app/configs/size_config.dart';

class ProductImagesWidget extends StatefulWidget {
  final Product product;

  const ProductImagesWidget({Key? key, required this.product})
      : super(key: key);
  @override
  _ProductImagesWidgetState createState() => _ProductImagesWidgetState();
}

class _ProductImagesWidgetState extends State<ProductImagesWidget> {
  Product get product => widget.product;

  // Local states
  int currentPage = 0;

  void onPageChanged(index) => setState(() => currentPage = index);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Product image preview
        Container(
          height: SizeConfig.defaultSize * 23,
          child: PageView.builder(
            itemCount: product.images.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRouter.DETAIL_IMAGE,
                    arguments: product.images[index],
                  );
                },
                child: Image.network(product.images[index]),
              );
            },
            onPageChanged: onPageChanged,
          ),
        ),

        /// Indicators
        Positioned(
          bottom: 0,
          width: SizeConfig.screenWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                product.images.length, (index) => _buildIndicator(index)),
          ),
        ),
      ],
    );
  }

  _buildIndicator(int index) {
    return AnimatedContainer(
      duration: mAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 3,
      width: currentPage == index
          ? SizeConfig.defaultSize * 6
          : SizeConfig.defaultSize * 3,
      decoration: BoxDecoration(
        color:
            currentPage == index ? COLOR_CONST.primaryColor : Color(0xFFD8D8D8),
      ),
    );
  }
}
