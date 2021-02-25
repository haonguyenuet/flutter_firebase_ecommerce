import 'package:e_commerce_app/app_view.dart';
import 'package:e_commerce_app/business_logic/blocs/auth/auth_bloc.dart';
import 'package:e_commerce_app/business_logic/blocs/auth/auth_event.dart';
import 'package:e_commerce_app/business_logic/repositories/detail_product_repo.dart';
import 'package:e_commerce_app/business_logic/repositories/home_repo.dart';
import 'package:e_commerce_app/business_logic/repositories/user_repo.dart';
import 'package:e_commerce_app/views/screens/home_page/bloc/home_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'business_logic/blocs/simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// This widget is the root of your application.
class MyApp extends StatelessWidget {
  final UserRepository _userRepository = UserRepository();
  final HomeRepository _homeRepository = HomeRepository();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => _userRepository),
        RepositoryProvider(create: (context) => _homeRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AuthenticationBloc(userRepository: _userRepository)
                  ..add(AppStarted()),
          ),
          BlocProvider(
              create: (context) => HomeBloc(homeRepository: _homeRepository)),
        ],
        child: AppView(),
      ),
    );
  }
}
