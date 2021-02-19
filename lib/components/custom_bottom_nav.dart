import 'package:e_commerce_app/screens/home_page/home_screen.dart';
import 'package:e_commerce_app/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import '../constants.dart';
import '../size_config.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({
    Key key,
    @required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(60),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0.15, 0.4),
            color: Colors.black,
          )
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/Shop Icon.svg",
                color: selectedMenu == MenuState.home
                    ? mPrimaryColor
                    : mSecondaryColor,
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  HomeScreen.routeName,
                  (_) => false,
                );
              },
            ),
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/User Icon.svg",
                color: selectedMenu == MenuState.profile
                    ? mPrimaryColor
                    : mSecondaryColor,
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  ProfileScreen.routeName,
                  (_) => false,
                );
              },
            ),
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/message.svg",
                color: mSecondaryColor,
              ),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
