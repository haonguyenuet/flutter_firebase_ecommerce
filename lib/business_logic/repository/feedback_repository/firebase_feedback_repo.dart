import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/business_logic/entities/feedback_item.dart';
import 'package:e_commerce_app/business_logic/repository/feedback_repository/feedback_repo.dart';

/// Feedbacks is collection type in each product
class FirebaseFeedbackRepository implements FeedbackRepository {
  var productCollection = FirebaseFirestore.instance.collection("products");

  /// Stream of feedback
  /// [pid] is product id
  /// Created by NDH
  @override
  Stream<List<FeedbackItem>> feedbackStream(String pid) {
    try {
      return productCollection
          .doc(pid)
          .collection("feedbacks")
          .orderBy("timestamp", descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => FeedbackItem.fromMap(doc.id, doc.data()))
              .toList());
    } catch (e) {
      print(e);
    }
    return null;
  }

  /// Add new doc to feedbacks collection
  /// [pid] is product id
  /// [newItem] is data of new feedback
  /// Created by NDH
  @override
  Future<List<FeedbackItem>> getFeedbacksByStar(String pid, int star) async {
    return star != 0
        ? await productCollection
            .doc(pid)
            .collection("feedbacks")
            .where("rating", isEqualTo: star)
            .orderBy("timestamp", descending: true)
            .get()
            .then((snapshot) => snapshot.docs
                .map((doc) => FeedbackItem.fromMap(doc.id, doc.data()))
                .toList())
            .catchError((error) => print(error))
        : await productCollection
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
  /// [pid] is product id
  /// [star] is number of stars
  /// Created by NDH
  @override
  Future<void> addNewFeedback(String pid, FeedbackItem newItem) async {
    var productRef = productCollection.doc(pid);
    await productRef
        .collection("feedbacks")
        .doc()
        .set(newItem.toMap())
        .catchError((error) => print(error));
  }
}
