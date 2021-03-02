import 'package:e_commerce_app/business_logic/entities/entites.dart';
import 'package:e_commerce_app/business_logic/repository/repository.dart';
import 'package:e_commerce_app/views/screens/feedback/bloc/bloc.dart';
import 'package:e_commerce_app/views/screens/feedback/widgets/app_bar.dart';
import 'package:e_commerce_app/views/screens/feedback/widgets/header.dart';
import 'package:e_commerce_app/views/screens/feedback/widgets/list_feedbacks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/feedback_bloc.dart';

class FeedbackScreen extends StatelessWidget {
  final Product product;

  const FeedbackScreen({Key key, @required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeedbackBloc(
        feedbackRepository: RepositoryProvider.of<FeedbackRepository>(context),
        productRepository: RepositoryProvider.of<ProductRepository>(context),
      )..add(LoadFeedbacks(product)),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              FeedbackAppBar(),
              Header(),
              Expanded(child: ListFeedbacks()),
            ],
          ),
        ),
      ),
    );
  }
}
