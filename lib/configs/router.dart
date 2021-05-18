import 'package:e_commerce_app/bottom_navigation.dart';
import 'package:e_commerce_app/data/models/models.dart';
import 'package:e_commerce_app/presentation/screens/detail_image/detail_image_screen.dart';
import 'package:e_commerce_app/presentation/screens/message/message_screen.dart';
import 'package:e_commerce_app/presentation/screens/detail_order/detail_order_screen.dart';
import 'package:e_commerce_app/presentation/screens/map/map_screen.dart';
import 'package:e_commerce_app/presentation/screens/my_orders/my_orders_screen.dart';
import 'package:e_commerce_app/presentation/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/presentation/screens/delivery_address/delivery_address_screen.dart';
import 'package:e_commerce_app/presentation/screens/categories/categories_screen.dart';
import 'package:e_commerce_app/presentation/screens/cart/cart_screen.dart';
import 'package:e_commerce_app/presentation/screens/detail_product/detail_product_screen.dart';
import 'package:e_commerce_app/presentation/screens/feedbacks/feedbacks_screen.dart';
import 'package:e_commerce_app/presentation/screens/initialize_info/initialize_info_screen.dart';
import 'package:e_commerce_app/presentation/screens/settings/setting_screen.dart';
import 'package:e_commerce_app/presentation/screens/login/login_screen.dart';
import 'package:e_commerce_app/presentation/screens/register/register_screen.dart';
import 'package:e_commerce_app/presentation/screens/splash/splash_screen.dart';

class AppRouter {
  static const String SPLASH = '/splash';
  static const String LOGIN = '/login';
  static const String INITIALIZE_INFO = '/initialize_info';
  static const String REGISTER = '/register';
  static const String FORGOT_PASSWORD = '/forgot_password';
  static const String HOME = '/home';
  static const String PROFILE = '/profile';
  static const String DETAIL_PRODUCT = '/detail_product';
  static const String DETAIL_IMAGE = '/detail_image';
  static const String FEEDBACK = '/feedback';
  static const String CART = '/cart';
  static const String MY_ORDERS = '/my_orders';
  static const String DETAIL_ORDER = '/detail_order';
  static const String DELIVERY_ADDRESS = '/delivery_address';
  static const String MAP = '/map';
  static const String CATEGORIES = '/categories';
  static const String SETTING = '/setting';
  static const String MESSAGES = '/messages';
  static const String SEARCH = '/search';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SPLASH:
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
        );
      case LOGIN:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      // case FORGOT_PASSWORD:
      //   return MaterialPageRoute(builder: (_) => ForgotPasswordScreen(),);
      case INITIALIZE_INFO:
        return MaterialPageRoute(
          builder: (_) => InitializeInfoScreen(),
        );
      case REGISTER:
        var initialUser = settings.arguments as UserModel;
        return MaterialPageRoute(
          builder: (_) => RegisterScreen(initialUser: initialUser),
        );
      case HOME:
        return MaterialPageRoute(
          builder: (_) => BottomNavigation(),
        );
      case SETTING:
        return MaterialPageRoute(
          builder: (_) => SettingScreen(),
        );
      case DETAIL_PRODUCT:
        var product = settings.arguments as Product;
        return MaterialPageRoute(
            builder: (_) => DetailProductScreen(product: product));
      case DETAIL_IMAGE:
        var imageUrl = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => DetailImageScreen(imageUrl: imageUrl),
        );
      case FEEDBACK:
        var product = settings.arguments as Product;
        return MaterialPageRoute(
            builder: (_) => FeedbacksScreen(product: product));
      case CATEGORIES:
        var category = settings.arguments as CategoryModel;
        return MaterialPageRoute(
            builder: (_) => CategoriesScreen(category: category));
      case CART:
        return MaterialPageRoute(
          builder: (_) => CartScreen(),
        );
      case MY_ORDERS:
        return MaterialPageRoute(
          builder: (_) => MyOrdersScreen(),
        );
      case DETAIL_ORDER:
        var order = settings.arguments as OrderModel;
        return MaterialPageRoute(
            builder: (_) => DetailOrderScreen(order: order));
      case DELIVERY_ADDRESS:
        return MaterialPageRoute(
          builder: (_) => DeliveryAddressModelScreen(),
        );
      case MAP:
        return MaterialPageRoute(
          builder: (_) => MapScreen(),
        );
      case MESSAGES:
        return MaterialPageRoute(
          builder: (_) => MessagesScreen(),
        );
      case SEARCH:
        return MaterialPageRoute(
          builder: (_) => SearchScreen(),
        );
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
