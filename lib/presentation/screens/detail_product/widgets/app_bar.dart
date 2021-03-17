import 'package:e_commerce_app/configs/router.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:e_commerce_app/presentation/widgets/buttons/cart_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DetailProductAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.defaultSize,
          horizontal: SizeConfig.defaultSize * 1.5,
        ),
        child: Row(
          children: [
            _buildBackHomeButton(context),
            Spacer(),
            CartButton(color: COLOR_CONST.textColor),
          ],
        ),
      ),
    );
  }

  _buildBackHomeButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(context, AppRouter.HOME);
      },
      child: Container(
        height: SizeConfig.defaultSize * 4,
        width: SizeConfig.defaultSize * 4,
        padding: EdgeInsets.all(SizeConfig.defaultSize * 1.2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFF5F6F9),
        ),
        child: SvgPicture.asset("assets/icons/cancel.svg"),
      ),
    );
  }
}
