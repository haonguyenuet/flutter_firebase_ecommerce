import 'package:e_commerce_app/business_logic/entities/entites.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/presentation/screens/feedbacks/bloc/bloc.dart';
import 'package:e_commerce_app/presentation/screens/feedbacks/widgets/feedback_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedbackAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: mDarkShadeColor,
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.defaultSize,
        horizontal: SizeConfig.defaultSize * 1.5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildLeading(context),
          _buildTitle(),
          _buildActions(context),
        ],
      ),
    );
  }

  _buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios, color: mAccentTintColor),
      onPressed: () => Navigator.pop(context),
    );
  }

  _buildActions(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.add, color: mAccentTintColor),
          onPressed: () => _openModalBottomSheet(context),
        )
      ],
    );
  }

  _buildTitle() {
    return Text(
      'Feedbacks',
      style: FONT_CONST.BOLD_WHITE_18,
    );
  }

  void _openModalBottomSheet(BuildContext context) async {
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
      builder: (BuildContext context) {
        return FeedbackBottomSheet();
      },
    );
    if (newFeedback != null) {
      BlocProvider.of<FeedbackBloc>(context).add(AddFeedback(newFeedback));
    }
  }
}
