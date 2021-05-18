import 'package:e_commerce_app/data/models/models.dart';

abstract class FeedbackRepository {
  /// Stream of feedback
  /// [pid] is product id
  /// Created by NDH
  Stream<List<FeedBackModel>>? fetchFeedbacks(String pid);

  /// Add new doc to feedbacks collection
  /// [pid] is product id
  /// [newItem] is data of new feedback
  /// Created by NDH
  Future<void> addNewFeedback(String pid, FeedBackModel newItem);

  /// Get feedbacks by star
  /// [pid] is product id
  /// [star] is number of stars
  /// Created by NDH
  Future<List<FeedBackModel>> getFeedbacksByStar(String pid, int star);
}
