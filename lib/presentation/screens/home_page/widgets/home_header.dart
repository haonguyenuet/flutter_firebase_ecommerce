import 'package:e_commerce_app/configs/router.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/presentation/widgets/buttons/cart_button.dart';
import 'package:e_commerce_app/presentation/widgets/custom_widgets.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/constants/color_constant.dart';

class HomePersistentHeader extends SliverPersistentHeaderDelegate {
  double _mainHeaderHeight = SizeConfig.defaultSize * 4;
  double _searchFieldHeight = SizeConfig.defaultSize * 5;
  double _insetVertical = SizeConfig.defaultSize * 1.5;
  double _insetHorizontal = SizeConfig.defaultSize * 1.5;
  // _mainHeaderHeight + 2*_insetVertical
  double _minHeaderExtent = SizeConfig.defaultSize * 8;
  // _mainHeaderHeight + _searchFieldHeight + 2*_insetVertical + whiteSpace
  double _maxHeaderExtent =
      SizeConfig.defaultSize * 13 + SizeConfig.defaultSize / 2;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final size = MediaQuery.of(context).size;
    final offsetPercent = shrinkOffset / _maxHeaderExtent;
    var rangeSearchFieldWidth = (1 - offsetPercent).clamp(0.8, 1);
    return AnimatedContainer(
      duration: mAnimationDuration,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            spreadRadius: 1,
            color: COLOR_CONST.cardShadowColor.withOpacity(0.2),
            offset: Offset(0, 2),
          ),
        ],
      ),
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
                  opacity: offsetPercent > 0.1 ? 0 : 1,
                  duration: Duration(microseconds: 500),
                  child: Text(
                    "Peachy",
                    style: FONT_CONST.BOLD_PRIMARY_26,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    CartButton(),
                    const SizedBox(width: 15),
                    MessageButton(),
                  ],
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
              child: SearchFieldWidget(
                readOnly: true,
                onTap: () => Navigator.pushNamed(context, AppRouter.SEARCH),
                hintText: Translate.of(context)
                    .translate('what_would_you_search_today'),
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
