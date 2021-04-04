import 'package:e_commerce_app/business_logic/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:e_commerce_app/configs/size_config.dart';

class ProductImages extends StatefulWidget {
  final Product product;

  const ProductImages({Key? key, required this.product}) : super(key: key);
  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  Product get product => widget.product;
  // local states
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Product image preview
        Container(
          height: SizeConfig.defaultSize * 23,
          child: PageView.builder(
            itemCount: product.images.length,
            itemBuilder: (context, index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.white,
                child: Image.network(product.images[index]),
              );
            },
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
          ),
        ),

        /// dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              List.generate(product.images.length, (index) => createDot(index)),
        ),
      ],
    );
  }

  AnimatedContainer createDot(int index) {
    return AnimatedContainer(
      duration: mAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 3,
      width: _currentPage == index
          ? SizeConfig.defaultSize * 6
          : SizeConfig.defaultSize * 3,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? COLOR_CONST.primaryColor
            : Color(0xFFD8D8D8),
      ),
    );
  }
}
