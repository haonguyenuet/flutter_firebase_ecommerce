import 'package:e_commerce_app/business_logic/blocs/auth/auth_bloc.dart';
import 'package:e_commerce_app/business_logic/blocs/auth/auth_event.dart';
import 'package:e_commerce_app/configs/router.dart';
import 'package:e_commerce_app/views/screens/profile/widgets/profile_header.dart';
import 'package:e_commerce_app/views/screens/profile/widgets/profile_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfileHeader(),
          SizedBox(height: 20),
          ProfileMenuButton(
            text: "My Information",
            icon: "assets/icons/User Icon.svg",
            press: () => {},
          ),
          ProfileMenuButton(
            text: "My Cart",
            icon: "assets/icons/Cart Icon.svg",
            press: () {
              Navigator.pushNamed(context, AppRouter.CART);
            },
          ),
          ProfileMenuButton(
            text: "Log Out",
            icon: "assets/icons/exit.svg",
            press: () {
              BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
            },
          ),
        ],
      ),
    );
  }
}
