import 'package:e_commerce_app/business_logic/entities/feedback_item.dart';

abstract class FeedbackRepository {
  /// Stream of feedback
  /// [pid] is product id
  /// Created by NDH
  Stream<List<FeedbackItem>> feedbackStream(String pid);

  /// Add new doc to feedbacks collection
  /// [pid] is product id
  /// [newItem] is data of new feedback
  /// Created by NDH
  Future<void> addNewFeedback(String pid, FeedbackItem newItem);

  /// Get feedbacks by star
  /// [pid] is product id
  /// [star] is number of stars
  /// Created by NDH
  Future<List<FeedbackItem>> getFeedbacksByStar(String pid, int star);
}
