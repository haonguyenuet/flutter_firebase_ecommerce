import 'package:e_commerce_app/business_logic/entities/feedback.dart';
import 'package:e_commerce_app/business_logic/entities/user.dart';
import 'package:e_commerce_app/business_logic/repository/user_repository/firebase_user_repo.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:e_commerce_app/presentation/widgets/others/custom_card_widget.dart';
import 'package:e_commerce_app/presentation/widgets/others/rating_bar.dart';
import 'package:flutter/material.dart';

class FeedbackCard extends StatelessWidget {
  const FeedbackCard({
    Key? key,
    required this.feedBack,
  }) : super(key: key);

  final FeedBack feedBack;

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      margin: EdgeInsets.symmetric(
        vertical: SizeConfig.defaultSize * 0.5,
        horizontal: SizeConfig.defaultSize,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.defaultSize * 2,
        vertical: SizeConfig.defaultSize,
      ),
      child: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.start,
        spacing: 10,
        children: [
          _buildUserInfo(),
          _buildRating(),
          _buildFeedbackContent(),
          _buildCreatedDate()
        ],
      ),
    );
  }

  _buildUserInfo() {
    return FutureBuilder(
      future: FirebaseUserRepository().getUserById(feedBack.userId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var user = snapshot.data as UserModel;
          return Row(
            children: [
              CircleAvatar(
                backgroundImage: (user.avatar.isNotEmpty
                        ? NetworkImage(user.avatar)
                        : AssetImage("assets/images/default_avatar.jpg"))
                    as ImageProvider<Object>?,
              ),
              SizedBox(width: 5),
              // User email
              Text(user.email),
            ],
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  _buildRating() {
    return RatingBar(
      initialRating: feedBack.rating.toDouble(),
      itemSize: SizeConfig.defaultSize * 2,
    );
  }

  _buildFeedbackContent() {
    return Text(
      "${feedBack.content}",
      style: FONT_CONST.BOLD_DEFAULT_16,
    );
  }

  _buildCreatedDate() {
    return Text("${formatTimeStamp(feedBack.timestamp)}");
  }
}
