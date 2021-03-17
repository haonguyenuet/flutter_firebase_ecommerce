import 'package:e_commerce_app/constants/font_constant.dart';
import 'package:e_commerce_app/presentation/widgets/others/logo.dart';
import 'package:e_commerce_app/utils/translate.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/configs/size_config.dart';

class LoginHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 5),
      child: Column(
        children: [
          Logo(),
          Text(
            Translate.of(context).translate("welcome_back"),
            style: FONT_CONST.BOLD_WHITE_26,
          ),
          Text(
            Translate.of(context).translate("login_slogan"),
            
            style: FONT_CONST.REGULAR_WHITE,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
