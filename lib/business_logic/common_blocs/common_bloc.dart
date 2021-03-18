import 'package:e_commerce_app/business_logic/common_blocs/application/bloc.dart';
import 'package:e_commerce_app/business_logic/common_blocs/auth/bloc.dart';
import 'package:e_commerce_app/business_logic/common_blocs/cart/bloc.dart';
import 'package:e_commerce_app/business_logic/common_blocs/language/bloc.dart';
import 'package:e_commerce_app/business_logic/common_blocs/profile/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommonBloc {
  /// Bloc
  static final applicationBloc = ApplicationBloc();
  static final authencationBloc = AuthenticationBloc();
  static final languageBloc = LanguageBloc();
  static final cartBloc = CartBloc();
  static final profileBloc = ProfileBloc();

  static final List<BlocProvider> blocProviders = [
    BlocProvider<ApplicationBloc>(
      create: (context) => applicationBloc,
    ),
    BlocProvider<AuthenticationBloc>(
      create: (context) => authencationBloc,
    ),
    BlocProvider<LanguageBloc>(
      create: (context) => languageBloc,
    ),
    BlocProvider<ProfileBloc>(
      create: (context) => profileBloc,
    ),
    BlocProvider<CartBloc>(
      create: (context) => cartBloc,
    ),
  ];

  /// Dispose
  static void dispose() {
    applicationBloc.close();
    authencationBloc.close();
    cartBloc.close();
    profileBloc.close();
    languageBloc.close();
  }

  /// Singleton factory
  static final CommonBloc _instance = CommonBloc._internal();

  factory CommonBloc() {
    return _instance;
  }
  CommonBloc._internal();
}
