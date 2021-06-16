import 'package:e_commerce_app/presentation/screens/home_page/bloc/bloc.dart';
import 'package:e_commerce_app/presentation/screens/home_page/widgets/home_body.dart';
import 'package:e_commerce_app/presentation/screens/home_page/widgets/home_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(LoadHome()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<HomeBloc>(context).add(RefreshHome());
                },
                child: CustomScrollView(
                  physics: AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  slivers: [
                    SliverPersistentHeader(
                      delegate: HomePersistentHeader(),
                      pinned: true,
                    ),
                    HomeBody(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
