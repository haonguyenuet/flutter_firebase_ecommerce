import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DeliveryUnit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: mAccentTintColor.withOpacity(0.2),
        border: Border(
          top: BorderSide(color: mAccentTintColor, width: 1),
          bottom: BorderSide(color: mAccentTintColor, width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(child: _buildInfo()),
          Text("30,000₫"),
        ],
      ),
    );
  }

  _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset("assets/icons/shipped.svg", width: 24),
            SizedBox(width: 10),
            Text(
              "Delivery Unit",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: mDarkShadeColor,
              ),
            ),
          ],
        ),
        Text(
          "Fast delivery",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Text("J&T Express"),
        Text(
          "Receive this order in 5 Th03 - 8 Th03",
          style: TextStyle(
            color: Colors.black38,
          ),
        )
      ],
    );
  }
}
