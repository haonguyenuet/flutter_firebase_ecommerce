import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/business_logic/blocs/profile/bloc.dart';
import 'package:e_commerce_app/business_logic/entities/feedback.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/views/widgets/buttons/default_button.dart';
import 'package:e_commerce_app/views/widgets/others/rating_bar.dart';
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
            SizedBox(height: 20),
            _buildCommentSection(),
            SizedBox(height: 20),
            _buildRatingSection(),
            SizedBox(height: 10),
            _buildAddButton(context),
          ],
        ),
      ),
    );
  }

  _buildHeader() {
    return Align(
      alignment: Alignment.center,
      child: Text('Add your feedback', style: FONT_CONST.REGULAR_DEFAULT_16),
    );
  }

  _buildCommentSection() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: mPrimaryLightColor,
      ),
      child: TextField(
        autofocus: true,
        onChanged: (value) => setState(() => _content = value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          border: InputBorder.none,
          hintText: "Type...",
        ),
        maxLines: null,
      ),
    );
  }

  _buildRatingSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Rating:", style: FONT_CONST.BOLD_DEFAULT_16),
        SizedBox(width: 10),
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
            width: 200,
            child: DefaultButton(
              child: Text("Send", style: FONT_CONST.BOLD_WHITE_18),
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
