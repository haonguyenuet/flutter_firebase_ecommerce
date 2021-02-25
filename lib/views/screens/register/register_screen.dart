import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/business_logic/repositories/user_repo.dart';
import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:e_commerce_app/views/screens/register/bloc/register_bloc.dart';
import 'package:e_commerce_app/views/screens/register/widgets/register_form.dart';
import 'package:e_commerce_app/views/screens/register/widgets/register_header.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userRepository = RepositoryProvider.of<UserRepository>(context);
    return BlocProvider(
      create: (context) => RegisterBloc(userRepository: userRepository),
      child: Scaffold(
        backgroundColor: mPrimaryColor,
        body: SafeArea(
          child: ListView(
            children: [
              RegisterHeader(),
              RegisterForm(),
            ],
          ),
        ),
      ),
    );
  }
}
