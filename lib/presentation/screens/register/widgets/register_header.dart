import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/presentation/widgets/others/logo.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/configs/size_config.dart';

class RegisterHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.defaultSize * 5), // 50
        Logo(),
        Text(
          Translate.of(context).translate('register_now').toUpperCase(),
          style: FONT_CONST.BOLD_WHITE_26,
        ),
        Text(
          Translate.of(context).translate('it_so_quick_and_easy'),
          style: FONT_CONST.REGULAR_WHITE,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: SizeConfig.defaultSize * 5),
      ],
    );
  }
}
