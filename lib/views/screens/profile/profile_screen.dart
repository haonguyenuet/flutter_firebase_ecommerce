import 'package:e_commerce_app/business_logic/blocs/auth/bloc.dart';
import 'package:e_commerce_app/configs/router.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/views/screens/profile/widgets/profile_header.dart';
import 'package:e_commerce_app/views/screens/profile/widgets/profile_menu_button.dart';
import 'package:e_commerce_app/views/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            ProfileHeader(),
            SizedBox(height: 20),
            ProfileMenuButton(
              text: "My Information",
              icon: "assets/icons/User Icon.svg",
              onPressed: () => {},
            ),
            ProfileMenuButton(
              text: "My Cart",
              icon: "assets/icons/Cart Icon.svg",
              onPressed: () {
                Navigator.pushNamed(context, AppRouter.CART);
              },
            ),
            ProfileMenuButton(
              text: "Log Out",
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
