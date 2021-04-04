import 'package:e_commerce_app/presentation/screens/login/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/presentation/screens/login/widgets/login_form.dart';
import 'package:e_commerce_app/presentation/screens/login/widgets/login_header.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        body: ListView(
          children: [
            LoginHeader(),
            LoginForm(),
          ],
        ),
      ),
    );
  }
}
