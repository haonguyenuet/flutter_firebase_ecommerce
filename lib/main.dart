import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/app_view.dart';
import 'package:e_commerce_app/views/screens/home_page/bloc/home_bloc.dart';
import 'business_logic/blocs/auth/bloc.dart';
import 'business_logic/blocs/simple_bloc_observer.dart';
import 'business_logic/repository/repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// This widget is the root of your application.
class MyApp extends StatelessWidget {
  final UserRepository _userRepository = FirebaseUserRepository();
  final ProductRepository _productRepository = FirebaseProductRepository();
  final BannerRepository _bannerRepository = FirebaseBannerRepository();
  final CartRepository _cartRepository = FirebaseCartRepository();
  final FeedbackRepository _feedbackRepository = FirebaseFeedbackRepository();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => _userRepository),
        RepositoryProvider(create: (context) => _productRepository),
        RepositoryProvider(create: (context) => _bannerRepository),
        RepositoryProvider(create: (context) => _cartRepository),
        RepositoryProvider(create: (context) => _feedbackRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AuthenticationBloc(userRepository: _userRepository)
                  ..add(AppStarted()),
          ),
          BlocProvider(
              create: (context) => HomeBloc(
                    bannerRepository: _bannerRepository,
                    productRepository: _productRepository,
                  )),
        ],
        child: AppView(),
      ),
    );
  }
}
