import 'package:e_commerce_app/data/entities/feedback.dart';

abstract class FeedbackRepository {
  /// Stream of feedback
  /// [pid] is product id
  /// Created by NDH
  Stream<List<FeedBack>>? feedbackStream(String pid);

  /// Add new doc to feedbacks collection
  /// [pid] is product id
  /// [newItem] is data of new feedback
  /// Created by NDH
  Future<void> addNewFeedback(String pid, FeedBack newItem);

  /// Get feedbacks by star
  /// [pid] is product id
  /// [star] is number of stars
  /// Created by NDH
  Future<List<FeedBack>> getFeedbacksByStar(String pid, int star);
}
