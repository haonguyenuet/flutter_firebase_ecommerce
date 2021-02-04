import 'package:flutter/material.dart';

import '../../../size_config.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key key,
    this.title,
    this.handleOnTap,
  }) : super(key: key);

  final String title;
  final Function handleOnTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          
          GestureDetector(
            onTap: handleOnTap,
            child: Text(
              "See more",
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
