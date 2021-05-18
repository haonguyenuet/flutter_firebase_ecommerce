import 'package:e_commerce_app/data/models/models.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/presentation/screens/feedbacks/bloc/bloc.dart';
import 'package:e_commerce_app/presentation/screens/feedbacks/widgets/feedback_bottom_sheet.dart';
import 'package:e_commerce_app/presentation/screens/feedbacks/widgets/header.dart';
import 'package:e_commerce_app/presentation/screens/feedbacks/widgets/list_feedbacks.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedbacksScreen extends StatelessWidget {
  final Product product;

  const FeedbacksScreen({Key? key, required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeedbackBloc()..add(LoadFeedbacks(product)),
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
            floatingActionButton: _buildFloatingActionButton(context),
          );
        },
      ),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_sharp, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        Translate.of(context).translate("feedback"),
        style: FONT_CONST.BOLD_WHITE_20,
      ),
      backgroundColor: COLOR_CONST.primaryColor,
      elevation: 0,
    );
  }

  _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => _openFeedbackBottomSheet(context),
      label: Text(
        Translate.of(context).translate("add_your_feedback"),
        style: FONT_CONST.BOLD_WHITE_16,
      ),
      icon: Icon(Icons.add),
    );
  }

  _openFeedbackBottomSheet(BuildContext context) async {
    var feedbackBloc = BlocProvider.of<FeedbackBloc>(context);
    showModalBottomSheet<FeedBackModel>(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (_) => feedbackBloc,
          child: FeedbackBottomSheet(),
        );
      },
    );
  }
}
