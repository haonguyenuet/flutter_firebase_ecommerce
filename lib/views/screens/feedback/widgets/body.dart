import 'package:e_commerce_app/business_logic/entities/feedback_item.dart';

import 'package:e_commerce_app/views/screens/feedback/widgets/no_feedback.dart';
import 'package:flutter/material.dart';
import 'feedback_card.dart';
import 'header.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<FeedbackItem> feedbacks = [];
    return SafeArea(
      child: Column(
        children: [
          Header(),
          Expanded(
            child: feedbacks.length > 0
                ? ListView.builder(
                    itemCount: feedbacks.length,
                    itemBuilder: (context, index) {
                      return FeedbackCard(feedbackItem: feedbacks[index]);
                    },
                  )
                : NoFeedback(),
          )
        ],
      ),
    );
  }
}
