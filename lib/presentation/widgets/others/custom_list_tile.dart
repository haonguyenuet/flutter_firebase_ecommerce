import 'package:e_commerce_app/configs/config.dart';
import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String? subTitle;
  final Widget? trailing;
  final Widget? icon;
  final Function()? onPressed;
  final bool bottomBorder;

  const CustomListTile({
    Key? key,
    required this.title,
    this.subTitle,
    this.trailing,
    this.icon,
    this.onPressed,
    this.bottomBorder = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          _iconWidget(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: _bottomBorder(),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 16, bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title, style: FONT_CONST.BOLD_PRIMARY_18),
                          _subTitle()
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize),
                    child: trailing ?? Container(),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _subTitle() {
    return subTitle != null
        ? Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              subTitle!,
              style: FONT_CONST.REGULAR_PRIMARY_16,
            ),
          )
        : Container();
  }

  _iconWidget() {
    return icon != null
        ? Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: icon,
          )
        : Container();
  }

  _bottomBorder() {
    return bottomBorder
        ? Border(
            bottom: BorderSide(
              width: 1,
              color: COLOR_CONST.dividerColor,
            ),
          )
        : null;
  }
}
