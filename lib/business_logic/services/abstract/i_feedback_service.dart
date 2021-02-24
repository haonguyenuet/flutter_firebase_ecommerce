import 'package:e_commerce_app/business_logic/entities/feedback_item.dart';

abstract class IFeedbackService {
  // Get all feedback items
  Future<List<FeedbackItem>> getFeedbacks();

  // Add new feedback
  Future<void> addNewFeedback(FeedbackItem newItem);

  // Get feedbacks by star
  Future<List<FeedbackItem>> getFeedbacksByStar(int star);
}
