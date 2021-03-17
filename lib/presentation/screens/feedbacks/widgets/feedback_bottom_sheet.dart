import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/business_logic/blocs/profile/bloc.dart';
import 'package:e_commerce_app/business_logic/entities/feedback.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/presentation/widgets/buttons/default_button.dart';
import 'package:e_commerce_app/presentation/widgets/others/rating_bar.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/constants/color_constant.dart';

class FeedbackBottomSheet extends StatefulWidget {
  const FeedbackBottomSheet({Key? key}) : super(key: key);

  @override
  _FeedbackBottomSheetState createState() => _FeedbackBottomSheetState();
}

class _FeedbackBottomSheetState extends State<FeedbackBottomSheet> {
  // local states
  int _rating = 5;
  String _content = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: SizeConfig.defaultSize * 2),
            _buildCommentSection(),
            SizedBox(height: SizeConfig.defaultSize * 2),
            _buildRatingSection(),
            SizedBox(height: SizeConfig.defaultSize),
            _buildAddButton(context),
          ],
        ),
      ),
    );
  }

  _buildHeader() {
    return Align(
      alignment: Alignment.center,
      child: Text(
        Translate.of(context).translate('your_feedback'),
        style: FONT_CONST.REGULAR_DEFAULT_16,
      ),
    );
  }

  _buildCommentSection() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: COLOR_CONST.backgroundColor,
      ),
      child: TextField(
        autofocus: true,
        onChanged: (value) => setState(() => _content = value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: SizeConfig.defaultSize * 1.5,
            vertical: SizeConfig.defaultSize,
          ),
          border: InputBorder.none,
          hintText: Translate.of(context).translate('type_something'),
        ),
        maxLines: null,
      ),
    );
  }

  _buildRatingSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(Translate.of(context).translate('rating') + ": ",
            style: FONT_CONST.BOLD_DEFAULT_16),
        SizedBox(width: SizeConfig.defaultSize),
        RatingBar(
          initialRating: 5,
          onRatingUpdate: (value) => setState(() => _rating = value),
        )
      ],
    );
  }

  _buildAddButton(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: SizeConfig.defaultSize * 20,
            child: DefaultButton(
              child: Text(
                Translate.of(context).translate('send'),
                style: FONT_CONST.BOLD_WHITE_18,
              ),
              onPressed: () {
                // create new feedback
                FeedBack newFeedback = FeedBack(
                  id: UniqueKey().toString(),
                  userId: state is ProfileLoaded ? state.loggedUser.id : "",
                  rating: _rating,
                  content: _content,
                  timestamp: Timestamp.now(),
                );
                // return new feedback to main screen
                Navigator.pop(context, newFeedback);
              },
            ),
          ),
        );
      },
    );
  }
}
