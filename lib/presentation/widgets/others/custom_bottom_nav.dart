import 'package:e_commerce_app/configs/config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.defaultSize * 1.5,
        vertical: SizeConfig.defaultSize,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -0.1),
            blurRadius: 5,
            color: COLOR_CONST.darkShadeColor.withOpacity(0.2),
          )
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            /// Home
            BottomMenuButton(
              isSelected: selectedMenu == MenuState.home,
              iconPath: ICON_CONST.HOME,
              buttonName: "Home",
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRouter.HOME,
                  (_) => false,
                );
              },
            ),

            /// Profile
            BottomMenuButton(
              isSelected: selectedMenu == MenuState.profile,
              iconPath: ICON_CONST.USER,
              buttonName: "Profile",
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRouter.PROFILE,
                  (_) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

///
class BottomMenuButton extends StatelessWidget {
  const BottomMenuButton({
    Key? key,
    required this.isSelected,
    required this.iconPath,
    required this.buttonName,
    required this.onTap,
  }) : super(key: key);

  final bool isSelected;
  final String iconPath, buttonName;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: mAnimationDuration,
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.defaultSize * 2,
          vertical: SizeConfig.defaultSize,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected
              ? COLOR_CONST.primaryColor.withOpacity(0.16)
              : Colors.transparent,
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
              color: isSelected
                  ? COLOR_CONST.primaryColor
                  : COLOR_CONST.secondaryColor,
            ),
            SizedBox(width: 5),
            if (isSelected) Text(buttonName, style: FONT_CONST.BOLD_PRIMARY)
          ],
        ),
      ),
    );
  }
}
