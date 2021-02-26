import 'package:e_commerce_app/business_logic/entities/feedback_item.dart';

abstract class FeedbackRepository {
  // Get all feedback items
  Future<List<FeedbackItem>> getFeedbacks(String pid);

  // Add new feedback
  Future<void> addNewFeedback(String pid, FeedbackItem newItem);

  // Get feedbacks by star
  Future<List<FeedbackItem>> getFeedbacksByStar(String pid, int star);
}
