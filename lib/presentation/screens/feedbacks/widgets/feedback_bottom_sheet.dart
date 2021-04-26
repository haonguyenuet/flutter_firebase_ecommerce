import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/presentation/common_blocs/profile/bloc.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/presentation/screens/feedbacks/bloc/bloc.dart';
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
  int rating = 5;
  String content = "";

  void addFeeback() {
    if (content.isEmpty) return;

    BlocProvider.of<FeedbackBloc>(context).add(AddFeedback(
      rating: rating,
      content: content,
    ));
    Navigator.pop(context);
  }

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
        style: FONT_CONST.BOLD_DEFAULT_20,
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
        onChanged: (value) => setState(() => content = value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: SizeConfig.defaultPadding,
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
      children: [
        Text(Translate.of(context).translate('rating') + ": ",
            style: FONT_CONST.BOLD_DEFAULT_18),
        SizedBox(width: SizeConfig.defaultSize),
        RatingBar(
          initialRating: 5,
          onRatingUpdate: (value) => setState(() => rating = value),
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
              onPressed: addFeeback,
            ),
          ),
        );
      },
    );
  }
}
