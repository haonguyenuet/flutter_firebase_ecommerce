import 'package:e_commerce_app/presentation/screens/feedbacks/bloc/bloc.dart';
import 'package:e_commerce_app/presentation/widgets/others/loading.dart';
import 'package:e_commerce_app/presentation/widgets/single_card/feedback_card.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListFeedbacks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedbackBloc, FeedbackState>(
      builder: (context, state) {
        if (state is FeedbacksLoaded) {
          var feedbacks = state.feedbacks;
          return feedbacks.length > 0
              ? ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: feedbacks.length,
                  itemBuilder: (context, index) {
                    return FeedbackCard(feedBack: feedbacks[index]);
                  },
                )
              : Center(
                  child: Text(Translate.of(context).translate("no_feedbacks")),
                );
        }
        if (state is FeedbacksLoading) {
          return Loading();
        }
        if (state is FeedbacksLoadFailure) {
          return Center(child: Text("Load Failure"));
        }

        return Center(child: Text("Something went wrongs."));
      },
    );
  }
}
