import 'package:e_commerce_app/business_logic/entities/product.dart';
import 'package:e_commerce_app/utils/common_func.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:e_commerce_app/configs/size_config.dart';

class ProductImages extends StatefulWidget {
  final Product product;

  const ProductImages({Key key, this.product}) : super(key: key);
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
        SizedBox(
          height: getProportionateScreenWidth(230),
          child: PageView.builder(
            itemCount: product.images.length,
            itemBuilder: (context, index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.white,
                child: FutureBuilder(
                  future: loadImage(product.images[index]),
                  builder: (context, snapshot) {
                    return (snapshot.hasData)
                        ? Image.network(snapshot.data)
                        : SpinKitCircle(color: mPrimaryColor);
                  },
                ),
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
        width: _currentPage == index ? 60 : 30,
        decoration: BoxDecoration(
          color: _currentPage == index ? mPrimaryColor : Color(0xFFD8D8D8),
        ));
  }
}
