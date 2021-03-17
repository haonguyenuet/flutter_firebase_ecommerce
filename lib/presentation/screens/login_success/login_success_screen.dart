import 'package:e_commerce_app/business_logic/blocs/profile/bloc.dart';
import 'package:e_commerce_app/configs/router.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/presentation/widgets/custom_widgets.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(Translate.of(context).translate('login_success')),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                _buildSuccessImage(),
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                _buildGreeting(),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                _buildGoToHomeButton(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildSuccessImage() {
    return Image.asset(
      "assets/images/success.png",
      height: SizeConfig.screenHeight * 0.5,
    );
  }

  _buildGoToHomeButton(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth * 0.6,
      child: DefaultButton(
        child: Text(Translate.of(context).translate('go_to_home'),
            style: FONT_CONST.BOLD_WHITE_18),
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRouter.HOME,
            (_) => false,
          );
        },
      ),
    );
  }

  _buildGreeting() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          var loggedUser = state.loggedUser;
          return Text.rich(
            TextSpan(
              style: FONT_CONST.BOLD_DEFAULT_20,
              children: [
                TextSpan(text: Translate.of(context).translate('hello,')),
                TextSpan(
                  text: "${loggedUser.name}",
                  style: FONT_CONST.BOLD_PRIMARY_20,
                )
              ],
            ),
          );
        }
        if (state is ProfileLoading) {
          return Loading();
        }
        return Center(child: Text("Something went wrongs."));
      },
    );
  }
}
