import 'package:e_commerce_app/views/widgets/buttons/cart_button.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/constants/color_constant.dart';

class HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildTitle(),
            _buildActions(),
          ],
        ));
  }

  _buildActions() {
    return Row(
      children: [CartButton(counter: 3)],
    );
  }

  _buildTitle() {
    return Text(
      'Peachy',
      style: TextStyle(
        fontSize: 26,
        color: mPrimaryColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
