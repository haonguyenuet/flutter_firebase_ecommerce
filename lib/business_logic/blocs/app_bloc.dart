import 'package:e_commerce_app/business_logic/blocs/auth/bloc.dart';
import 'package:e_commerce_app/business_logic/blocs/cart/bloc.dart';
import 'package:e_commerce_app/business_logic/blocs/language/bloc.dart';
import 'package:e_commerce_app/business_logic/blocs/profile/bloc.dart';
import 'package:e_commerce_app/business_logic/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBloc {
  /// Repository
  static final _authRepository = FirebaseAuthRepository();
  static final _userRepository = FirebaseUserRepository();
  static final _productRepository = FirebaseProductRepository();
  static final _bannerRepository = FirebaseBannerRepository();
  static final _cartRepository = FirebaseCartRepository();
  static final _feedbackRepository = FirebaseFeedbackRepository();
  static final _storageRepository = StorageRepository();

  static final List<RepositoryProvider> repoProviders = [
    RepositoryProvider<AuthRepository>(
      create: (context) => _authRepository,
    ),
    RepositoryProvider<UserRepository>(
      create: (context) => _userRepository,
    ),
    RepositoryProvider<ProductRepository>(
      create: (context) => _productRepository,
    ),
    RepositoryProvider<BannerRepository>(
      create: (context) => _bannerRepository,
    ),
    RepositoryProvider<CartRepository>(
      create: (context) => _cartRepository,
    ),
    RepositoryProvider<FeedbackRepository>(
      create: (context) => _feedbackRepository,
    ),
  ];

  /// Bloc
  static final _authencationBloc = AuthenticationBloc(
    authRepository: _authRepository,
  );
  static final _languageBloc = LanguageBloc();
  static final _cartBloc = CartBloc(cartRepository: _cartRepository);
  static final _profileBloc = ProfileBloc(
    userRepository: _userRepository,
    storageRepository: _storageRepository,
  );

  static final List<BlocProvider> blocProviders = [
    BlocProvider<AuthenticationBloc>(
      create: (context) => _authencationBloc..add(AppStarted()),
    ),
    BlocProvider<LanguageBloc>(
      create: (context) => _languageBloc,
    ),
    BlocProvider<ProfileBloc>(
      create: (context) => _profileBloc,
    ),
    BlocProvider<CartBloc>(
      create: (context) => _cartBloc,
    ),
  ];

  /// Dispose
  static void dispose() {
    _authencationBloc.close();
    _cartBloc.close();
    _profileBloc.close();
    _languageBloc.close();
  }

  /// Singleton factory
  static final AppBloc _instance = AppBloc._internal();

  factory AppBloc() {
    return _instance;
  }
  AppBloc._internal();
}
