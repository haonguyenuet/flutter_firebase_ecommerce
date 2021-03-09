import 'package:e_commerce_app/business_logic/entities/feedback.dart';
import 'package:e_commerce_app/business_logic/entities/user.dart';
import 'package:e_commerce_app/business_logic/repository/user_repository/firebase_user_repo.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:e_commerce_app/views/widgets/others/rating_bar.dart';
import 'package:flutter/material.dart';

class FeedbackCard extends StatelessWidget {
  const FeedbackCard({
    Key? key,
    required this.feedBack,
  }) : super(key: key);

  final FeedBack feedBack;

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
      future: FirebaseUserRepository().getUserById(feedBack.userId),
      builder: (context, snapshot) {
        var user = snapshot.data as UserModel;
        return snapshot.hasData
            ? Row(
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
              )
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  _buildRating() {
    return RatingBar(
      initialRating: feedBack.rating.toDouble(),
      itemSize: 20,
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
