import 'package:e_commerce_app/business_logic/common_blocs/profile/bloc.dart';
import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_picture.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: SizeConfig.screenHeight * 0.3,
      color: COLOR_CONST.primaryColor,
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoaded) {
            var _loggedUser = state.loggedUser;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProfilePic(loggedUser: _loggedUser),
                Text(
                  "${_loggedUser.name}",
                  style: FONT_CONST.BOLD_WHITE_20,
                )
              ],
            );
          }
          return Center(child: Text("Something went wrongs."));
        },
      ),
    );
  }
}
