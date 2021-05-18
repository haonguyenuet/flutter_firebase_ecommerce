import 'package:e_commerce_app/data/models/models.dart';
import 'package:e_commerce_app/data/repository/app_repository.dart';
import 'package:e_commerce_app/data/repository/repository.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/constants/image_constant.dart';
import 'package:e_commerce_app/presentation/widgets/custom_widgets.dart';
import 'package:e_commerce_app/presentation/widgets/others/custom_card_widget.dart';
import 'package:e_commerce_app/utils/formatter.dart';
import 'package:flutter/material.dart';

class FeedbackCard extends StatelessWidget {
  const FeedbackCard({
    Key? key,
    required this.feedBack,
  }) : super(key: key);

  final FeedBackModel feedBack;

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      child: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.start,
        spacing: 10,
        children: [
          _buildUserInfo(context),
          _buildRating(),
          _buildFeedbackContent(),
          _buildCreatedDate()
        ],
      ),
    );
  }

  _buildUserInfo(BuildContext context) {
    return FutureBuilder(
      future: AppRepository.userRepository.getUserById(feedBack.userId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var user = snapshot.data as UserModel;
          return Row(
            children: [
              CircleAvatar(
                backgroundImage: (user.avatar.isNotEmpty
                        ? NetworkImage(user.avatar)
                        : AssetImage(IMAGE_CONST.DEFAULT_AVATAR))
                    as ImageProvider<Object>?,
              ),
              SizedBox(width: 5),
              // User email
              Text(user.email),
            ],
          );
        }
        return Center(child: Loading());
      },
    );
  }

  _buildRating() {
    return RatingBar(
      readOnly: true,
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
    return Text("${UtilFormatter.formatTimeStamp(feedBack.timestamp)}");
  }
}
