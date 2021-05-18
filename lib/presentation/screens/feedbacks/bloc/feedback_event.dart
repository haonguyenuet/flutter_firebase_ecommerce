import 'package:e_commerce_app/data/models/models.dart';

import 'package:equatable/equatable.dart';

abstract class FeedbacksEvent extends Equatable {
  const FeedbacksEvent();

  @override
  List<Object?> get props => [];
}

/// When open feedback screen
class LoadFeedbacks extends FeedbacksEvent {
  final Product product;

  LoadFeedbacks(this.product);

  @override
  List<Object> get props => [product];
}

class AddFeedback extends FeedbacksEvent {
  final String content;
  final int rating;

  AddFeedback({required this.content, required this.rating});

  @override
  List<Object?> get props => [content, rating];
}

class StarChanged extends FeedbacksEvent {
  final int star;

  StarChanged(this.star);

  @override
  List<Object> get props => [star];
}

class FeedbacksUpdated extends FeedbacksEvent {
  final List<FeedBackModel> feedbacks;

  FeedbacksUpdated(this.feedbacks);

  @override
  List<Object> get props => [feedbacks];
}
