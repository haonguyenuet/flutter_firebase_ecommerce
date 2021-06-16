import 'package:e_commerce_app/configs/config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/presentation/screens/initialize_info/widgets/initialize_info_form.dart';
import 'package:e_commerce_app/presentation/screens/initialize_info/widgets/initialize_info_header.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:flutter/material.dart';

class InitializeInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              InitializeInfoHeader(),
              InitializeInfoForm(),
            ],
          ),
        ),
        bottomNavigationBar: _buildHaveAccountText(context),
      ),
    );
  }

  _buildHaveAccountText(context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            Translate.of(context).translate("already_have_an_account"),
            style: FONT_CONST.REGULAR_DEFAULT_20,
          ),
          SizedBox(width: 5),
          GestureDetector(
            onTap: () => Navigator.pushNamedAndRemoveUntil(
              context,
              AppRouter.LOGIN,
              (_) => false,
            ),
            child: Text(
              Translate.of(context).translate("login"),
              style: FONT_CONST.BOLD_PRIMARY_20,
            ),
          ),
        ],
      ),
    );
  }
}
