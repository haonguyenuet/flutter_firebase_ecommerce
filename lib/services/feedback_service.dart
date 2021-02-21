import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/feedback_item.dart';
import 'package:meta/meta.dart';

import 'abstract/i_feedback_service.dart';

/// Feedbacks is collection type in each product
class FeedbackService extends IFeedbackService {
  String pid; // Selected product Id
  var productCollection = FirebaseFirestore.instance.collection("products");

  /// Constructor
  /// Created by NDH
  FeedbackService({@required this.pid});

  /// Get all feedback items
  /// Created by NDH
  @override
  Future<List<FeedbackItem>> getFeedbacks() async {
    return await productCollection
        .doc(pid)
        .collection("feedbacks")
        .orderBy("timestamp", descending: true)
        .get()
        .then((snapshot) => snapshot.docs
            .map((doc) => FeedbackItem.fromMap(doc.id, doc.data()))
            .toList())
        .catchError((error) => print(error));
  }

  /// Get feedbacks by star
  /// Created by NDH
  @override
  Future<List<FeedbackItem>> getFeedbacksByStar(int star) async {
    return await productCollection
        .doc(pid)
        .collection("feedbacks")
        .where("rating", isEqualTo: star)
        .orderBy("timestamp", descending: true)
        .get()
        .then((snapshot) => snapshot.docs
            .map((doc) => FeedbackItem.fromMap(doc.id, doc.data()))
            .toList())
        .catchError((error) => print(error));
  }

  /// Add new feedback
  /// Created by NDH
  @override
  Future<void> addNewFeedback(FeedbackItem newItem) async {
    var productRef = productCollection.doc(pid);
    await productRef
        .collection("feedbacks")
        .doc()
        .set(newItem.toMap())
        .catchError((error) => print(error));
  }
}
