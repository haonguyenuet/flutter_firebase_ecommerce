import 'package:e_commerce_app/presentation/screens/chat/chat_screen.dart';
import 'package:e_commerce_app/presentation/screens/map/map_screen.dart';
import 'package:e_commerce_app/presentation/screens/payment/payment_success_screen.dart';
import 'package:e_commerce_app/presentation/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/business_logic/entities/entites.dart';
import 'package:e_commerce_app/presentation/screens/delivery_address/delivery_address_screen.dart';
import 'package:e_commerce_app/presentation/screens/categories/categories_screen.dart';
import 'package:e_commerce_app/presentation/screens/cart/cart_screen.dart';
import 'package:e_commerce_app/presentation/screens/detail_product/detail_product_screen.dart';
import 'package:e_commerce_app/presentation/screens/feedbacks/feedbacks_screen.dart';
import 'package:e_commerce_app/presentation/screens/initialize_info/initialize_info_screen.dart';
import 'package:e_commerce_app/presentation/screens/login_success/login_success_screen.dart';
import 'package:e_commerce_app/presentation/screens/profile/profile_screen.dart';
import 'package:e_commerce_app/presentation/screens/settings/setting_screen.dart';
import 'package:e_commerce_app/presentation/screens/home_page/home_screen.dart';
import 'package:e_commerce_app/presentation/screens/login/login_screen.dart';
import 'package:e_commerce_app/presentation/screens/register/register_screen.dart';
import 'package:e_commerce_app/presentation/screens/splash/splash_screen.dart';

class AppRouter {
  static const String HOME = '/home';
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
  static const String PAYMENT_SUCCESS = '/payment_success';
  static const String DELIVERY_ADDRESS = '/delivery_address';
  static const String MAP = '/map';
  static const String ALL_PRODUCTS = '/all_products';
  static const String SETTING = '/setting';
  static const String CHAT = '/chat';
  static const String SEARCH = '/search';

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
        var initialUser = settings.arguments as UserModel;
        return MaterialPageRoute(
            builder: (_) => RegisterScreen(initialUser: initialUser));
      case LOGIN_SUCCESS:
        return MaterialPageRoute(builder: (_) => LoginSuccessScreen());
      case HOME:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case PROFILE:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case SETTING:
        return MaterialPageRoute(builder: (_) => SettingScreen());
      case DETAIL_PRODUCT:
        var product = settings.arguments as Product;
        return MaterialPageRoute(
            builder: (_) => DetailProductScreen(product: product));
      case FEEDBACK:
        var product = settings.arguments as Product;
        return MaterialPageRoute(
            builder: (_) => FeedbacksScreen(product: product));
      case ALL_PRODUCTS:
        var category = settings.arguments as Category;
        return MaterialPageRoute(
            builder: (_) => AllProductsScreen(category: category));
      case CART:
        return MaterialPageRoute(builder: (_) => CartScreen());
      case PAYMENT_SUCCESS:
        return MaterialPageRoute(builder: (_) => PaymentSuccessScreen());
      case DELIVERY_ADDRESS:
        return MaterialPageRoute(builder: (_) => DeliveryAddressScreen());
      case MAP:
        return MaterialPageRoute(builder: (_) => MapScreen());
      case CHAT:
        return MaterialPageRoute(builder: (_) => ChatScreen());
      case SEARCH:
        return MaterialPageRoute(builder: (_) => SearchScreen());
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

  ///Singleton factory
  static final AppRouter _instance = AppRouter._internal();

  factory AppRouter() {
    return _instance;
  }

  AppRouter._internal();
}
