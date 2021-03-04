import 'package:e_commerce_app/business_logic/entities/entites.dart';
import 'package:e_commerce_app/business_logic/entities/feedback_item.dart';
import 'package:equatable/equatable.dart';

abstract class FeedbackEvent extends Equatable {
  const FeedbackEvent();

  @override
  List<Object> get props => [];
}

/// When open feedback screen
class LoadFeedbacks extends FeedbackEvent {
  final Product product;

  LoadFeedbacks(this.product);

  @override
  List<Object> get props => [product.id];
}

/// When user clicks to add feedback
class AddFeedbackItem extends FeedbackEvent {
  final FeedbackItem feedback;

  AddFeedbackItem(this.feedback);

  @override
  List<Object> get props => [feedback.fid];
}

/// When user clicks to
class StarChanged extends FeedbackEvent {
  final int star;

  StarChanged(this.star);

  @override
  List<Object> get props => [star];
}

/// When
class FeedbacksUpdated extends FeedbackEvent {
  final List<FeedbackItem> feedbacks;

  FeedbacksUpdated(this.feedbacks);

  @override
  List<Object> get props => [feedbacks];
}
