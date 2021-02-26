import 'package:e_commerce_app/business_logic/entities/product.dart';
import 'package:e_commerce_app/business_logic/entities/user.dart';
import 'package:e_commerce_app/views/screens/cart/cart_screen.dart';
import 'package:e_commerce_app/views/screens/detail_product/detail_product_screen.dart';
import 'package:e_commerce_app/views/screens/feedback/feedback_screen.dart';
import 'package:e_commerce_app/views/screens/forgot_password/forgot_password_screen.dart';
import 'package:e_commerce_app/views/screens/initialize_info/initialize_info_screen.dart';
import 'package:e_commerce_app/views/screens/login_success/login_success_screen.dart';
import 'package:e_commerce_app/views/screens/profile/profile_screen.dart';
import 'package:e_commerce_app/views/screens/show_all/category_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/views/screens/home_page/home_screen.dart';
import 'package:e_commerce_app/views/screens/login/login_screen.dart';
import 'package:e_commerce_app/views/screens/register/register_screen.dart';
import 'package:e_commerce_app/views/screens/splash/splash_screen.dart';

class AppRouter {
  static const String HOME = '/';
  static const String SPLASH = '/splash';
  static const String LOGIN = '/login';
  static const String INITIALIZE_INFO = '/initialize_info';
  static const String REGISTER = '/register';
  static const String LOGIN_SUCCESS = '/login_success';
  static const String FORGOT_PASSWORD = '/forgot_password';
  static const String PROFILE = '/profile';
  static const String show_details = '/show_details';
  static const String FEEDBACK = '/feedback';
  static const String CART = '/cart';
  static const String SHOW_ALL = '/show_all';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SPLASH:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case LOGIN:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case INITIALIZE_INFO:
        return MaterialPageRoute(builder: (_) => InitializeInfoScreen());
      case REGISTER:
        var initialUser = settings.arguments as UserModel;
        return MaterialPageRoute(
          builder: (_) => RegisterScreen(initialUser: initialUser),
        );
      case LOGIN_SUCCESS:
        var user = settings.arguments as UserModel;
        return MaterialPageRoute(
          builder: (_) => LoginSuccessScreen(currUser: user),
        );
      case HOME:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case PROFILE:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case show_details:
        var product = settings.arguments as Product;
        return MaterialPageRoute(
          builder: (_) => DetailProductScreen(product: product),
        );
      case FEEDBACK:
        return MaterialPageRoute(builder: (_) => FeedbackScreen());
      case SHOW_ALL:
        return MaterialPageRoute(builder: (_) => ShowAllScreen());
      case FORGOT_PASSWORD:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      case CART:
        return MaterialPageRoute(builder: (_) => CartScreen());
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
