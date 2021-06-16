import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:flutter/material.dart';

class SearchFieldWidget extends StatelessWidget {
  final TextEditingController? searchController;
  final bool readOnly;
  final bool autoFocus;
  final Function()? onTap;
  final String? hintText;
  final double? height;

  const SearchFieldWidget({
    Key? key,
    this.readOnly = false,
    this.autoFocus = false,
    this.onTap,
    this.searchController,
    this.hintText = "",
    this.height,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? SizeConfig.defaultSize * 5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConfig.defaultSize * 2),
        color: COLOR_CONST.cardShadowColor.withOpacity(0.3),
      ),
      child: TextField(
        controller: searchController,
        keyboardType: TextInputType.text,
        autofocus: autoFocus,
        readOnly: readOnly,
        onTap: onTap,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          isDense: true,
          hintText: hintText,
          hintStyle: FONT_CONST.REGULAR_DEFAULT_20,
          prefixStyle: FONT_CONST.REGULAR_DEFAULT_20,
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
