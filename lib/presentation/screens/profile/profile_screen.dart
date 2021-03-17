import 'package:e_commerce_app/business_logic/blocs/auth/bloc.dart';
import 'package:e_commerce_app/configs/router.dart';
import 'package:e_commerce_app/configs/size_config.dart';
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
              icon: "assets/icons/Settings.svg",
              onPressed: () {
                Navigator.pushNamed(context, AppRouter.SETTING);
              },
            ),
            ProfileMenuButton(
              text: Translate.of(context).translate("cart"),
              icon: "assets/icons/Cart Icon.svg",
              onPressed: () {
                Navigator.pushNamed(context, AppRouter.CART);
              },
            ),
            ProfileMenuButton(
              text: Translate.of(context).translate("log_out"),
              icon: "assets/icons/exit.svg",
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
