import 'package:e_commerce_app/configs/router.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/presentation/widgets/buttons/cart_button.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/constants/color_constant.dart';

class HomePersistentHeader extends SliverPersistentHeaderDelegate {
  double _mainHeaderHeight = SizeConfig.defaultSize * 4;
  double _searchFieldHeight = SizeConfig.defaultSize * 4;
  double _insetVertical = SizeConfig.defaultSize * 1.5;
  double _insetHorizontal = SizeConfig.defaultSize * 1.5;
  // _mainHeaderHeight + 2*_insetVertical
  double _minHeaderExtent = SizeConfig.defaultSize * 7;
  // _mainHeaderHeight + _searchFieldHeight + 2*_insetVertical + 5
  double _maxHeaderExtent = SizeConfig.defaultSize * 11 + 5;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final size = MediaQuery.of(context).size;
    final offsetPercent = shrinkOffset / _maxHeaderExtent;
    var rangeSearchFieldWidth = (1 - offsetPercent).clamp(0.9, 1);
    return AnimatedContainer(
      duration: mAnimationDuration,
      color: offsetPercent > 0.2 ? Colors.white : mDarkShadeColor,
      child: Stack(
        children: [
          Positioned(
            top: _insetVertical,
            left: _insetHorizontal,
            right: _insetHorizontal,
            height: _mainHeaderHeight,
            child: Row(
              children: [
                AnimatedOpacity(
                  opacity: offsetPercent > 0.2 ? 0 : 1,
                  duration: Duration(seconds: 1),
                  child: Text(
                    "Peachy",
                    style: FONT_CONST.BOLD_WHITE_26,
                  ),
                ),
                Spacer(),
                CartButton(
                  color: offsetPercent > 0.2 ? mTextColor : Colors.white,
                )
              ],
            ),
          ),
          Positioned(
            bottom: _insetVertical,
            left: 0,
            height: _searchFieldHeight,
            width: size.width * rangeSearchFieldWidth,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: _insetHorizontal),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: TextField(
                onTap: () =>
                    Navigator.pushNamed(context, AppRouter.ALL_PRODUCTS),
                readOnly: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "What do you search today?",
                  hintStyle: FONT_CONST.REGULAR_DEFAULT_18,
                  prefixStyle: FONT_CONST.REGULAR_DEFAULT_18,
                  contentPadding: EdgeInsets.all(0),
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
