import 'package:e_commerce_app/size_config.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'list_products.dart';

class Body extends StatefulWidget {
  final String typeOfProduct;

  const Body({Key key, this.typeOfProduct}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // init states
  int selectedCategoryIndex = 0;

  @override
  void initState() {
    for (int i = 0; i < categories.length; i++) {
      if (categories[i]["category"] == widget.typeOfProduct) {
        selectedCategoryIndex = i;
        break;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          _buildCategories(),
          SizedBox(height: 10),
          Expanded(
            child: ListProducts(
                category: categories[selectedCategoryIndex]["category"]),
          ),
        ],
      ),
    );
  }

  Container _buildCategories() {
    return Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(categories.length, (index) {
                return buildCategory(index);
              })
            ],
          ),
        ));
  }

  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategoryIndex = index;
        });
      },
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              categories[index]["name"],
              style: TextStyle(
                color: selectedCategoryIndex == index
                    ? mPrimaryColor
                    : mSecondaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 4),
              width: 30,
              height: 3,
              decoration: BoxDecoration(
                color: selectedCategoryIndex == index
                    ? mPrimaryColor
                    : Colors.transparent,
              ),
            )
          ],
        ),
      ),
    );
  }
}
