import 'package:e_commerce_app/views/screens/feedback/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:e_commerce_app/constants/color_constant.dart';

class Header extends StatefulWidget {
  const Header({
    Key key,
  }) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  // local states
  int selectedStarIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      color: mDarkShadeColor,
      child: Column(
        children: [
          _buildFeedbackStats(),
          _buildSelectStarSection(context),
        ],
      ),
    );
  }

  _buildFeedbackStats() {
    return BlocBuilder<FeedbackBloc, FeedbackState>(
      buildWhen: (prevState, currState) {
        return currState is FeedbacksLoaded;
      },
      builder: (context, state) {
        if (state is FeedbacksLoaded) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.all(15),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${state.feedbackResponse.rating}",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                RatingBar.builder(
                  initialRating: state.feedbackResponse.rating,
                  minRating: 1,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 26,
                  unratedColor: mAccentShadeColor,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: null,
                ),
                const SizedBox(height: 15),
                Text(
                  "${state.feedbackResponse.numberOfFeedbacks} nhận xét",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
          );
        }
        return Center(child: Text("Something went wrongs."));
      },
    );
  }

  _buildSelectStarSection(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Get all feedbacks button
          GestureDetector(
            onTap: () {
              setState(() => selectedStarIndex = 0);
              BlocProvider.of<FeedbackBloc>(context).add(StarChanged(0));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "All",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: selectedStarIndex == 0 ? mPrimaryColor : mTextColor,
                ),
              ),
            ),
          ),

          // Get feedbacks by number of stars
          ...List.generate(5, (index) {
            return StarButton(
              numberOfStars: 5 - index,
              isActive: selectedStarIndex == 5 - index,
              handleOnTap: () {
                setState(() => selectedStarIndex = 5 - index);
                // get feedbacks by star ( 1 -> 5)
                BlocProvider.of<FeedbackBloc>(context)
                    .add(StarChanged(5 - index));
              },
            );
          })
        ],
      ),
    );
  }
}

class StarButton extends StatelessWidget {
  const StarButton({
    Key key,
    @required this.numberOfStars,
    this.handleOnTap,
    this.isActive = false,
  }) : super(key: key);

  final int numberOfStars;
  final Function() handleOnTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleOnTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Text(
              "$numberOfStars",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 5),
            Icon(
              Icons.star,
              color: isActive ? Colors.amber : mAccentShadeColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
