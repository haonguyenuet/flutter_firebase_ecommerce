import 'package:e_commerce_app/configs/config.dart';
import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final Widget? subTitle;
  final Widget? trailing;
  final Widget? leading;
  final Function()? onPressed;
  final bool bottomBorder;

  const CustomListTile({
    Key? key,
    required this.title,
    this.subTitle,
    this.trailing,
    this.leading,
    this.onPressed,
    this.bottomBorder = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.only(
          top: SizeConfig.defaultSize * 2,
          bottom: SizeConfig.defaultSize * 2,
          right: SizeConfig.defaultSize * 1.5,
        ),
        decoration: BoxDecoration(
          border: _bottomBorder(),
        ),
        child: Row(
      
          children: [
            _leadingWidget(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: FONT_CONST.BOLD_DEFAULT_18, maxLines: 2),
                  _subTitle()
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize),
              child: trailing ?? Container(),
            ),
          ],
        ),
      ),
    );
  }

  _subTitle() {
    return subTitle != null
        ? Padding(
            padding: EdgeInsets.only(top: 5),
            child: subTitle,
          )
        : Container();
  }

  _leadingWidget() {
    return leading != null
        ? SizedBox(
            width: SizeConfig.defaultSize * 10,
            child: leading,
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
        :null;
  }
}
