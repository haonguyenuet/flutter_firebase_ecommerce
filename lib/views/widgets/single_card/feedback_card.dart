import 'package:e_commerce_app/business_logic/entities/feedback_item.dart';
import 'package:e_commerce_app/business_logic/entities/user.dart';
import 'package:e_commerce_app/business_logic/repository/user_repository/firebase_user_repo.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/utils/my_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedbackCard extends StatelessWidget {
  const FeedbackCard({
    Key? key,
    required this.feedbackItem,
  }) : super(key: key);

  final FeedbackItem feedbackItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFF5F6F9), width: 4)),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
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
      future: FirebaseUserRepository().getUserById(feedbackItem.uid),
      builder: (context, snapshot) {
        UserModel? user = snapshot.data as UserModel;
        return snapshot.hasData
            ? Row(
                children: [
                  CircleAvatar(
                    backgroundImage: (user.avatar!.isNotEmpty
                            ? NetworkImage(user.avatar!)
                            : AssetImage("assets/images/default_avatar.jpg"))
                        as ImageProvider<Object>?,
                  ),
                  SizedBox(width: 5),
                  // User email
                  Text(user.email),
                ],
              )
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  _buildRating() {
    return RatingBar.builder(
      initialRating: feedbackItem.rating.toDouble(),
      minRating: 1,
      allowHalfRating: true,
      itemSize: 20,
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (double value) {},
    );
  }

  _buildFeedbackContent() {
    return Text(
      "${feedbackItem.content}",
      style: FONT_CONST.BOLD_DEFAULT_16,
    );
  }

  _buildCreatedDate() {
    return Text("${formatTimeStamp(feedbackItem.timestamp!)}");
  }
}
