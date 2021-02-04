import 'package:e_commerce_app/common/common_func.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ProductImages extends StatefulWidget {
  final Product product;

  const ProductImages({Key key, this.product}) : super(key: key);
  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  Product get product => widget.product;
  // init states
  int selectedPreview = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: getProportionateScreenWidth(238),
          child: PageView.builder(
            itemCount: product.images.length,
            itemBuilder: (context, index) {
              return Container(
                alignment: Alignment.center,
                // width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: FutureBuilder(
                  future:
                      getProductImage(product: product, index: selectedPreview),
                  builder: (context, snapshot) {
                    return (snapshot.hasData)
                        ? Image.network(snapshot.data)
                        : CircularProgressIndicator();
                  },
                ),
              );
            },
            onPageChanged: (index) {
              setState(() {
                selectedPreview = index;
              });
            },
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(
              product.images.length,
              (index) => buildProductPreview(index: index),
            )
          ],
        ),
      ],
    );
  }

  GestureDetector buildProductPreview({int index}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPreview = index;
        });
      },
      child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(right: 10),
          height: getProportionateScreenWidth(40),
          width: getProportionateScreenWidth(40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color: index == selectedPreview
                    ? mPrimaryColor
                    : Colors.transparent),
          ),
          child: FutureBuilder(
            future: getProductImage(product: product, index: index),
            builder: (context, snapshot) {
              return (snapshot.hasData)
                  ? Image.network(snapshot.data)
                  : CircularProgressIndicator();
            },
          )),
    );
  }
}
