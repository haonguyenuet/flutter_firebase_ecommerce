import 'package:e_commerce_app/data/entities/user.dart';
import 'package:e_commerce_app/presentation/screens/register/register/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/presentation/screens/register/widgets/register_form.dart';
import 'package:e_commerce_app/presentation/screens/register/widgets/register_header.dart';

class RegisterScreen extends StatelessWidget {
  final UserModel initialUser;

  const RegisterScreen({Key? key, required this.initialUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
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
