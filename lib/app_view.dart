import 'package:e_commerce_app/business_logic/blocs/app_bloc.dart';
import 'package:e_commerce_app/business_logic/blocs/language/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'business_logic/blocs/profile/bloc.dart';
import 'business_logic/blocs/auth/bloc.dart';
import 'business_logic/blocs/cart/bloc.dart';
import 'configs/config.dart';
import 'utils/translate.dart';

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get _navigator => _navigatorKey.currentState;

  @override
  void dispose() {
    AppBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: _navigatorKey,
          title: 'Peachy E-Commerce',
          theme: AppTheme.currentTheme,
          onGenerateRoute: AppRouter.generateRoute,
          locale: AppLanguage.defaultLanguage,
          supportedLocales: AppLanguage.supportLanguage,
          localizationsDelegates: [
            Translate.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          initialRoute: AppRouter.SPLASH,
          builder: (context, child) {
            return BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state is Uninitialized) {
                  _onNavigate(AppRouter.SPLASH);
                } else if (state is Unauthenticated) {
                  _onNavigate(AppRouter.LOGIN);
                } else if (state is Authenticated) {
                  _loadUserProfile(state.loggedFirebaseUser);
                  _loadCart(state.loggedFirebaseUser);
                  _onNavigate(AppRouter.LOGIN_SUCCESS);
                } else {
                  _onNavigate(AppRouter.SPLASH);
                }
              },
              child: child,
            );
          },
        );
      },
    );
  }

  void _onNavigate(String route) {
    _navigator!.pushNamedAndRemoveUntil(route, (route) => false);
  }

  void _loadUserProfile(User loggedFirebaseUser) {
    BlocProvider.of<ProfileBloc>(context).add(LoadProfile(loggedFirebaseUser));
  }

  void _loadCart(User loggedFirebaseUser) {
    BlocProvider.of<CartBloc>(context).add(LoadCart(loggedFirebaseUser));
  }
}
