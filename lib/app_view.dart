import 'package:e_commerce_app/configs/application.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'business_logic/common_blocs/common_bloc.dart';
import 'business_logic/common_blocs/application/bloc.dart';
import 'business_logic/common_blocs/language/bloc.dart';
import 'business_logic/common_blocs/profile/bloc.dart';
import 'business_logic/common_blocs/auth/bloc.dart';
import 'business_logic/common_blocs/cart/bloc.dart';
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
  void initState() {
    CommonBloc.applicationBloc.add(SetupApplication());
    super.initState();
  }

  @override
  void dispose() {
    CommonBloc.dispose();
    super.dispose();
  }

  void _onNavigate(String route) {
    _navigator!.pushNamedAndRemoveUntil(route, (route) => false);
  }

  void _loadData() {
    // Only load data when authenticated
    BlocProvider.of<ProfileBloc>(context).add(LoadProfile());
    BlocProvider.of<CartBloc>(context).add(LoadCart());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        return MaterialApp(
          navigatorKey: _navigatorKey,
          debugShowCheckedModeBanner: Application.debug,
          title: Application.title,
          theme: AppTheme.currentTheme,
          onGenerateRoute: AppRouter.generateRoute,
          initialRoute: AppRouter.SPLASH,
          locale: AppLanguage.defaultLanguage,
          supportedLocales: AppLanguage.supportLanguage,
          localizationsDelegates: [
            Translate.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          builder: (context, child) {
            return BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state is Uninitialized) {
                  _onNavigate(AppRouter.SPLASH);
                } else if (state is Unauthenticated) {
                  _onNavigate(AppRouter.LOGIN);
                } else if (state is Authenticated) {
                  _loadData();
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
}
