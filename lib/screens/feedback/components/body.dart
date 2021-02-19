import 'package:e_commerce_app/models/feedback_item.dart';
import 'package:e_commerce_app/providers/feedback_provider.dart';
import 'package:e_commerce_app/screens/feedback/components/no_feedback.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'feedback_card.dart';
import 'header.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<FeedbackItem> feedbacks = context.watch<FeedbackProvider>().feedbacks;
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
