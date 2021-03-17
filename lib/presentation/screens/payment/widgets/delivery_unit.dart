import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DeliveryUnit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SizeConfig.defaultSize * 1.5),
      decoration: BoxDecoration(
        color: COLOR_CONST.accentTintColor.withOpacity(0.2),
        border: Border(
          top: BorderSide(color: COLOR_CONST.accentTintColor, width: 1),
          bottom: BorderSide(color: COLOR_CONST.accentTintColor, width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(child: _buildInfo(context)),
          Text("30,000₫"),
        ],
      ),
    );
  }

  _buildInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              "assets/icons/shipped.svg",
              width: SizeConfig.defaultSize * 2.4,
            ),
            SizedBox(width: SizeConfig.defaultSize),
            Text(
              Translate.of(context).translate("delivery_unit"),
              style: FONT_CONST.MEDIUM_DEFAULT_16,
            ),
          ],
        ),
        // Text("J&T Express"),
        // Text(
        //   "Receive this order in 5 Th03 - 8 Th03",
        //   style: TextStyle(
        //     color: Colors.black38,
        //   ),
        // )
      ],
    );
  }
}
