import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/presentation/screens/feedbacks/bloc/bloc.dart';
import 'package:e_commerce_app/presentation/widgets/others/rating_bar.dart';
import 'package:e_commerce_app/utils/translate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/constants/color_constant.dart';

class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  // local states
  int selectedStarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: SizeConfig.defaultSize),
      color: COLOR_CONST.primaryColor,
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
      buildWhen: (prevState, currState) => currState is FeedbacksLoaded,
      builder: (context, state) {
        if (state is FeedbacksLoaded) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.all(SizeConfig.defaultPadding),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${state.rating}",
                  style: FONT_CONST.BOLD_WHITE_26,
                ),
                RatingBar(initialRating: state.rating, readOnly: true),
                SizedBox(height: SizeConfig.defaultSize),
                Text(
                  "${state.numberOfFeedbacks} ${Translate.of(context).translate("feedbacks")}",
                  style: FONT_CONST.MEDIUM_WHITE_20,
                ),
              ],
            ),
          );
        }
        return Container();
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
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.defaultSize * 2,
                vertical: SizeConfig.defaultSize * 0.5,
              ),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "All",
                style:selectedStarIndex == 0 ? FONT_CONST.BOLD_PRIMARY_18 : FONT_CONST.BOLD_DEFAULT_18 ,
              ),
            ),
          ),

          // Get feedbacks by number of stars
          ...List.generate(5, (index) {
            var numberOfStars = 5 - index;
            return StarButton(
              numberOfStars: numberOfStars,
              isActive: selectedStarIndex == numberOfStars,
              handleOnTap: () {
                setState(() => selectedStarIndex = numberOfStars);
                // get feedbacks by star ( 1 -> 5)
                BlocProvider.of<FeedbackBloc>(context)
                    .add(StarChanged(numberOfStars));
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
    Key? key,
    required this.numberOfStars,
    this.handleOnTap,
    this.isActive = false,
  }) : super(key: key);

  final int numberOfStars;
  final Function()? handleOnTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleOnTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 0.5),
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.defaultPadding,
          vertical: SizeConfig.defaultSize * 0.5,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Text(
              "$numberOfStars",
              style: FONT_CONST.BOLD_DEFAULT,
            ),
            const SizedBox(width: 5),
            Icon(
              Icons.star,
              color: isActive ? Colors.amber : COLOR_CONST.textColor,
              size: SizeConfig.defaultSize * 2,
            ),
          ],
        ),
      ),
    );
  }
}
