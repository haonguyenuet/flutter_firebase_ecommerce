import 'package:e_commerce_app/common/common_func.dart';
import 'package:e_commerce_app/models/feedback_item.dart';
import 'package:e_commerce_app/models/user.dart';
import 'package:e_commerce_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class FeedbackCard extends StatelessWidget {
  const FeedbackCard({
    Key key,
    @required this.feedbackItem,
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
        horizontal: getProportionateScreenWidth(20),
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// User info
          FutureBuilder(
            future: UserService().getUserById(feedbackItem.uid),
            builder: (context, snapshot) {
              UserModel user = snapshot.data;
              return snapshot.hasData
                  ? Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: user.avatar.isNotEmpty
                              ? NetworkImage(user.avatar)
                              : AssetImage("assets/images/default_avatar.jpg"),
                        ),
                        // user email or user name
                        const SizedBox(width: 10),
                        Text(user.email),
                      ],
                    )
                  : Center(
                      child: SpinKitThreeBounce(color: mPrimaryColor, size: 20),
                    );
            },
          ),
          const SizedBox(height: 10),

          /// Rating
          RatingBar.builder(
            initialRating: feedbackItem.rating.toDouble(),
            minRating: 1,
            allowHalfRating: true,
            itemSize: 20,
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: null,
          ),
          const SizedBox(height: 10),

          /// Feedback content
          Text(
            "${feedbackItem.content}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),

          /// Feedback create date
          Text(
            "${formatTimeStamp(feedbackItem.timestamp)}",
            style: TextStyle(
              fontSize: 13,
            ),
          )
        ],
      ),
    );
  }
}
