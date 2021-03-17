import 'package:e_commerce_app/business_logic/entities/user.dart';
import 'package:e_commerce_app/business_logic/repository/repository.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/presentation/screens/register/widgets/register_form.dart';
import 'package:e_commerce_app/presentation/screens/register/widgets/register_header.dart';

import 'bloc/bloc.dart';

class RegisterScreen extends StatelessWidget {
  final UserModel initialUser;

  const RegisterScreen({Key? key, required this.initialUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(
        authRepository: RepositoryProvider.of<AuthRepository>(context),
      ),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(gradient: COLOR_CONST.primaryGradientColor),
          child: ListView(
            children: [
              RegisterHeader(),
              RegisterForm(intialUser: initialUser),
            ],
          ),
        ),
      ),
    );
  }
}
