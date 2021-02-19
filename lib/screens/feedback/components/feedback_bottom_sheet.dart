import 'package:e_commerce_app/components/default_button.dart';
import 'package:e_commerce_app/models/feedback_item.dart';
import 'package:e_commerce_app/providers/authentication_provider.dart';
import 'package:e_commerce_app/providers/feedback_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class FeedbackBottomSheet extends StatefulWidget {
  const FeedbackBottomSheet({
    Key key,
  }) : super(key: key);

  @override
  _FeedbackBottomSheetState createState() => _FeedbackBottomSheetState();
}

class _FeedbackBottomSheetState extends State<FeedbackBottomSheet> {
  // init states
  int rating = 5;
  var contentController = TextEditingController();

  void close() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Comment
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Nhận xét:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0XFFF5F6F9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: contentController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// Rating
            Container(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Rating:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  RatingBar.builder(
                    initialRating: rating.toDouble(),
                    minRating: 1,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) => setState(() {
                      this.rating = rating.round();
                    }),
                  ),
                ],
              ),
            ),

            /// Apply button
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: DefaultButton(
                handleOnPress: () {
                  FeedbackItem newFeedback = FeedbackItem(
                    fid: UniqueKey().toString(),
                    uid: context.read<AuthenticationProvider>().user.uid,
                    rating: rating,
                    content: contentController.text,
                  );
                  // add new feedback
                  context.read<FeedbackProvider>().addItem(newFeedback);
                  close();
                },
                text: "Apply",
              ),
            )
          ],
        ),
      ),
    );
  }
}
