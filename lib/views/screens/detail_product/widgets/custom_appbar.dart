import 'package:e_commerce_app/business_logic/entities/product.dart';
import 'package:e_commerce_app/configs/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:e_commerce_app/configs/size_config.dart';

class CustomAppBar extends PreferredSize {
  final Product product;

  CustomAppBar({@required this.product});

  @override
  // AppBar().preferredSize.height provide us the height that appy on our app bar
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            _buildBackHomeButton(context),
            Spacer(),
            _buildRatingButton(context)
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
        height: getProportionateScreenWidth(40),
        width: getProportionateScreenWidth(40),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFF5F6F9),
        ),
        child: Icon(Icons.cancel_rounded),
      ),
    );
  }

  _buildRatingButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRouter.FEEDBACK,
          arguments: product,
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        decoration: BoxDecoration(
          color: Color(0xFFF5F6F9),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Text(
              "${product.rating}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 5),
            SvgPicture.asset("assets/icons/Star Icon.svg"),
          ],
        ),
      ),
    );
  }
}
