import 'package:e_commerce_app/views/screens/login_success/login_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/views/screens/home_page/home_screen.dart';
import 'package:e_commerce_app/views/screens/login/login_screen.dart';
import 'package:e_commerce_app/views/screens/register/register_screen.dart';
import 'package:e_commerce_app/views/screens/splash/splash_screen.dart';

class AppRouter {
  static const String HOME = '/';

  static const String SPLASH = '/splash';
  static const String LOGIN = '/login';
  static const String REGISTER = '/register';
  static const String LOGIN_SUCCESS = '/login_success';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SPLASH:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case LOGIN:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case REGISTER:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case LOGIN_SUCCESS:
        return MaterialPageRoute(builder: (_) => LoginSuccessScreen());
      case HOME:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
