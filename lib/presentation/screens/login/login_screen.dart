import 'package:e_commerce_app/business_logic/repository/auth_repository/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:e_commerce_app/presentation/screens/login/bloc/login_bloc.dart';
import 'package:e_commerce_app/presentation/screens/login/widgets/login_form.dart';
import 'package:e_commerce_app/presentation/screens/login/widgets/login_header.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        authRepository: RepositoryProvider.of<AuthRepository>(context),
      ),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(gradient: COLOR_CONST.primaryGradientColor),
          child: ListView(
            children: [
              LoginHeader(),
              LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
