import 'package:e_commerce_app/configs/router.dart';
import 'package:e_commerce_app/views/widgets/buttons/cart_button.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/constants/color_constant.dart';

class HomePersistentHeader extends SliverPersistentHeaderDelegate {
  double _minHeaderExtent = 70;
  double _maxHeaderExtent = 120;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final size = MediaQuery.of(context).size;
    final percentOffset = shrinkOffset / _maxHeaderExtent;
    var rangeSearchFieldWidth = (1 - percentOffset).clamp(0.9, 1);
    return Container(
      color: mDarkShadeColor,
      child: Stack(
        children: [
          Positioned(
            top: 15,
            left: size.width * 0.5 - 50,
            height: 40,
            child: AnimatedOpacity(
              opacity: percentOffset > 0.1 ? 0 : 1,
              duration: Duration(seconds: 1),
              child: Text(
                "Peachy",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            top: 15,
            right: 15,
            height: 40,
            child: CartButton(counter: 3),
          ),
          AnimatedPositioned(
            bottom: 15,
            left: 0,
            height: 40,
            duration: Duration(microseconds: 200),
            width: size.width * rangeSearchFieldWidth,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: TextField(
                onTap: () =>
                    Navigator.pushNamed(context, AppRouter.ALL_PRODUCTS),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "What do you search today?",
                  contentPadding: EdgeInsets.only(top: 2),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => _maxHeaderExtent;

  @override
  double get minExtent => _minHeaderExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
