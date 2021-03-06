import 'package:e_commerce_app/business_logic/blocs/auth/bloc.dart';
import 'package:e_commerce_app/business_logic/entities/feedback_item.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/views/widgets/buttons/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:e_commerce_app/constants/color_constant.dart';

class FeedbackBottomSheet extends StatefulWidget {
  const FeedbackBottomSheet({Key? key}) : super(key: key);

  @override
  _FeedbackBottomSheetState createState() => _FeedbackBottomSheetState();
}

class _FeedbackBottomSheetState extends State<FeedbackBottomSheet> {
  // local states
  int rating = 5;
  String _content = "";

  void close() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
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
        RatingBar.builder(
          initialRating: rating.toDouble(),
          minRating: 1,
          allowHalfRating: false,
          itemCount: 5,
          itemSize: 24,
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) => setState(() {
            this.rating = rating.round();
          }),
        ),
      ],
    );
  }

  _buildAddButton(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: 200,
            child: DefaultButton(
              child: Text("Send", style: FONT_CONST.BOLD_WHITE_18),
              onPressed: () {
                // create new feedback
                FeedbackItem newFeedback = FeedbackItem(
                  fid: UniqueKey().toString(),
                  uid: state is Authenticated
                      ? state.loggedFirebaseUser.uid
                      : "",
                  rating: rating,
                  content: _content,
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
