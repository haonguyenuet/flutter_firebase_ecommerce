import 'package:e_commerce_app/bottom_navigation.dart';
import 'package:e_commerce_app/configs/application.dart';
import 'package:e_commerce_app/presentation/screens/login/login_screen.dart';
import 'package:e_commerce_app/presentation/screens/splash/splash_screen.dart';
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

  void loadData() {
    // Only load data when authenticated
    BlocProvider.of<ProfileBloc>(context).add(LoadProfile());
    BlocProvider.of<CartBloc>(context).add(LoadCart());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        return BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, authState) {
            return MaterialApp(
              debugShowCheckedModeBanner: Application.debug,
              title: Application.title,
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
              home: BlocBuilder<ApplicationBloc, ApplicationState>(
                builder: (context, applicationState) {
                  if (applicationState is ApplicationCompleted) {
                    if (authState is Unauthenticated) {
                      return LoginScreen();
                    }
                    if (authState is Authenticated) {
                      loadData();
                      return BottomNavigation();
                    }
                  }
                  return SplashScreen();
                },
              ),
            );
          },
        );
      },
    );
  }
}
