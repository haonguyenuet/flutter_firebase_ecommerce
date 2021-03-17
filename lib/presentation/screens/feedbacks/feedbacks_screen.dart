import 'package:e_commerce_app/business_logic/entities/entites.dart';
import 'package:e_commerce_app/business_logic/repository/repository.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/presentation/screens/feedbacks/bloc/bloc.dart';
import 'package:e_commerce_app/presentation/screens/feedbacks/widgets/feedback_bottom_sheet.dart';
import 'package:e_commerce_app/presentation/screens/feedbacks/widgets/header.dart';
import 'package:e_commerce_app/presentation/screens/feedbacks/widgets/list_feedbacks.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/feedback_bloc.dart';

class FeedbacksScreen extends StatelessWidget {
  final Product product;

  const FeedbacksScreen({Key? key, required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeedbackBloc(
        feedbackRepository: RepositoryProvider.of<FeedbackRepository>(context),
        productRepository: RepositoryProvider.of<ProductRepository>(context),
      )..add(LoadFeedbacks(product)),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: _buildAppBar(context),
            body: SafeArea(
              child: Column(
                children: [
                  Header(),
                  Expanded(child: ListFeedbacks()),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () => _openModalBottomSheet(context),
              label: Text(Translate.of(context).translate("add_your_feedback")),
              icon: Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_sharp, color: COLOR_CONST.accentTintColor),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        Translate.of(context).translate("feedback"),
        style: FONT_CONST.BOLD_WHITE_18,
      ),
      backgroundColor: COLOR_CONST.darkShadeColor,
    );
  }

  _openModalBottomSheet(BuildContext context) async {
    var newFeedback = await showModalBottomSheet<FeedBack>(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      context: context,
      builder: (BuildContext context) => FeedbackBottomSheet(),
    );
    if (newFeedback != null) {
      BlocProvider.of<FeedbackBloc>(context).add(AddFeedback(newFeedback));
    }
  }
}
