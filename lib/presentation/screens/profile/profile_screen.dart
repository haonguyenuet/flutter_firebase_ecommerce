import 'package:e_commerce_app/business_logic/common_blocs/auth/bloc.dart';
import 'package:e_commerce_app/configs/config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/presentation/screens/profile/widgets/profile_header.dart';
import 'package:e_commerce_app/presentation/screens/profile/widgets/profile_menu_button.dart';
import 'package:e_commerce_app/presentation/widgets/custom_widgets.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 2),
        child: Column(
          children: [
            ProfileHeader(),
            SizedBox(height: SizeConfig.defaultSize * 2),
            ProfileMenuButton(
              text: Translate.of(context).translate("settings"),
              icon: ICON_CONST.SETTING,
              onPressed: () {
                Navigator.pushNamed(context, AppRouter.SETTING);
              },
            ),
            ProfileMenuButton(
              text: Translate.of(context).translate("cart"),
              icon: ICON_CONST.CART,
              onPressed: () {
                Navigator.pushNamed(context, AppRouter.CART);
              },
            ),
            ProfileMenuButton(
              text: Translate.of(context).translate("log_out"),
              icon: ICON_CONST.LOG_OUT,
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNav(selectedMenu: MenuState.profile),
    );
  }
}
