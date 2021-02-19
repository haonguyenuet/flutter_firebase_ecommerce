import 'package:e_commerce_app/models/feedback_item.dart';
import 'package:e_commerce_app/services/abstract/i_feedback_service.dart';
import 'package:e_commerce_app/services/abstract/i_product_service.dart';
import 'package:e_commerce_app/services/feedback_service.dart';
import 'package:e_commerce_app/services/product_service.dart';
import 'package:flutter/cupertino.dart';

class FeedbackProvider with ChangeNotifier {
  IFeedbackService _feedbackService;
  IProductService _productService = ProductService();
  List<FeedbackItem> _feedbacks = [];
  double _averageRating = 0.0;
  String _pid;
  bool addNewItem = false;

  void setProductId(String pid) {
    _pid = pid;
    _feedbackService = FeedbackService(pid: pid);
  }

  // Get feedbacks
  void getFeedbacks({int star = 0}) async {
    // default star = 0, if star = 0 then get all feedbacks
    if (star == 0) {
      _feedbacks = await _feedbackService.getFeedbacks() ?? [];
      _averageRating = this.getAverageRating();
      if (addNewItem) {
        // update product rating
        await _productService.updateProductRatingById(_pid, _averageRating);
        addNewItem = false;
      }
    } else {
      _feedbacks = await _feedbackService.getFeedbacksByStar(star) ?? [];
    }
    notifyListeners();
  }

  // Add item
  void addItem(FeedbackItem newItem) async {
    addNewItem = true;
    await _feedbackService.addNewFeedback(newItem);
    // get feedbacks again
    this.getFeedbacks();
  }

  // Get average rating
  double getAverageRating() {
    int totalRating = 0;
    int numberOfRating = _feedbacks.length;
    _feedbacks.forEach((feedback) {
      totalRating += feedback.rating;
    });
    return numberOfRating > 0 ? totalRating / numberOfRating : 0.0;
  }

  // Get feedbacks
  List<FeedbackItem> get feedbacks => _feedbacks;
  // Get average rating
  double get averageRating => _averageRating;
  // Get numberOfFeedbacks
  int get numberOfFeedbacks => _feedbacks.length;
}
