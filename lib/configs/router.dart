import 'package:e_commerce_app/business_logic/entities/category.dart';
import 'package:e_commerce_app/business_logic/entities/product.dart';
import 'package:e_commerce_app/business_logic/entities/user.dart';
import 'package:e_commerce_app/views/screens/add_delivery_address/add_delivery_address.dart';
import 'package:e_commerce_app/views/screens/all_products/all_products_screen.dart';
import 'package:e_commerce_app/views/screens/cart/cart_screen.dart';
import 'package:e_commerce_app/views/screens/detail_product/detail_product_screen.dart';
import 'package:e_commerce_app/views/screens/feedback/feedback_screen.dart';
import 'package:e_commerce_app/views/screens/forgot_password/forgot_password_screen.dart';
import 'package:e_commerce_app/views/screens/initialize_info/initialize_info_screen.dart';
import 'package:e_commerce_app/views/screens/login_success/login_success_screen.dart';
import 'package:e_commerce_app/views/screens/payment/payment_screen.dart';
import 'package:e_commerce_app/views/screens/profile/profile_screen.dart';
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
  static const String DETAIL_PRODUCT = '/detail_product';
  static const String FEEDBACK = '/feedback';
  static const String CART = '/cart';
  static const String PAYMENT = '/payment';
  static const String ADD_DELIVERY_ADDRESS = '/add_delivery_address';
  static const String ALL_PRODUCTS = '/all_products';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SPLASH:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case LOGIN:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      // case FORGOT_PASSWORD:
      //   return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      case INITIALIZE_INFO:
        return MaterialPageRoute(builder: (_) => InitializeInfoScreen());
      case REGISTER:
        var initialUser = settings.arguments as UserModel?;
        return MaterialPageRoute(
            builder: (_) => RegisterScreen(initialUser: initialUser));
      case LOGIN_SUCCESS:
        return MaterialPageRoute(builder: (_) => LoginSuccessScreen());
      case HOME:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case PROFILE:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case DETAIL_PRODUCT:
        var product = settings.arguments as Product;
        return MaterialPageRoute(
            builder: (_) => DetailProductScreen(product: product));
      case FEEDBACK:
        var product = settings.arguments as Product;
        return MaterialPageRoute(
            builder: (_) => FeedbackScreen(product: product));
      case ALL_PRODUCTS:
        var category = settings.arguments as Category?;
        return MaterialPageRoute(
            builder: (_) => AllProductsScreen(category: category));
      case CART:
        return MaterialPageRoute(builder: (_) => CartScreen());
      case PAYMENT:
        return MaterialPageRoute(builder: (_) => PaymentScreen());
      case ADD_DELIVERY_ADDRESS:
        return MaterialPageRoute(builder: (_) => AddDeliveryAddressScreen());
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
