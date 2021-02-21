import 'package:e_commerce_app/screens/authentication/authentication_screen.dart';
import 'package:e_commerce_app/screens/cart/cart_screen.dart';
import 'package:e_commerce_app/screens/category/category_screen.dart';
import 'package:e_commerce_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:e_commerce_app/screens/detail_product/detail_product_screen.dart';
import 'package:e_commerce_app/screens/feedback/feedback_screen.dart';
import 'package:e_commerce_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:e_commerce_app/screens/home_page/home_screen.dart';
import 'package:e_commerce_app/screens/login_success/login_success_screen.dart';
import 'package:e_commerce_app/screens/profile/profile_screen.dart';
import 'package:e_commerce_app/screens/sign_in/sign_in_screen.dart';
import 'package:e_commerce_app/screens/sign_up/sign_up_screen.dart';
import 'package:e_commerce_app/screens/splash/splash_screen.dart';

import 'package:flutter/widgets.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailProductScreen.routeName: (context) => DetailProductScreen(),
  AuthenticationWrapper.routeName: (context) => AuthenticationWrapper(),
  CartScreen.routeName: (context) => CartScreen(),
  CategoryScreen.routeName: (context) => CategoryScreen(),
  FeedbackScreen.routeName: (context) => FeedbackScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
};
