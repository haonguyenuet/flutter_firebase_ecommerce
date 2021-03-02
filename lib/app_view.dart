import 'package:e_commerce_app/business_logic/blocs/profile/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/business_logic/blocs/auth/auth_bloc.dart';
import 'package:e_commerce_app/business_logic/blocs/auth/auth_state.dart';
import 'package:e_commerce_app/configs/themes/theme.dart';
import 'business_logic/blocs/cart/bloc.dart';
import 'configs/router.dart';

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peachy Ecommerce',
      theme: theme(),
      navigatorKey: _navigatorKey,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: AppRouter.SPLASH,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is Uninitialized) {
              _navigator.pushNamedAndRemoveUntil(
                AppRouter.SPLASH,
                (_) => false,
              );
            } else if (state is Unauthenticated) {
              _navigator.pushNamedAndRemoveUntil(
                AppRouter.LOGIN,
                (_) => false,
              );
            } else if (state is Authenticated) {
              var _loggedFirebaseUser = state.loggedFirebaseUser;
              // Load cart
              BlocProvider.of<CartBloc>(context)
                  .add(LoadCart(_loggedFirebaseUser));

              // Load profile
              BlocProvider.of<ProfileBloc>(context)
                  .add(LoadProfile(_loggedFirebaseUser));

              // Go to login success screen
              _navigator.pushNamedAndRemoveUntil(
                AppRouter.LOGIN_SUCCESS,
                (_) => false,
              );
            } else {
              // default case
              _navigator.pushNamedAndRemoveUntil(
                AppRouter.SPLASH,
                (_) => false,
              );
            }
          },
          child: child,
        );
      },
    );
  }
}
