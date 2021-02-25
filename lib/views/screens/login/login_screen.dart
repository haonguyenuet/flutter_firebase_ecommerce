import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/business_logic/repositories/user_repo.dart';
import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:e_commerce_app/views/screens/login/bloc/login_bloc.dart';
import 'package:e_commerce_app/views/screens/login/widgets/login_form.dart';
import 'package:e_commerce_app/views/screens/login/widgets/login_header.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userRepository = RepositoryProvider.of<UserRepository>(context);
    return BlocProvider(
      create: (context) => LoginBloc(userRepository: userRepository),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(gradient: mPrimaryGradientColor),
            child: ListView(
              children: [
                LoginHeader(),
                LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
