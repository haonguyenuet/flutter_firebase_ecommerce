import 'package:e_commerce_app/data/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class FeedbackState extends Equatable {
  const FeedbackState();

  @override
  List<Object> get props => [];
}

/// Feedbacks loading
class FeedbacksLoading extends FeedbackState {}

/// Feedbacks was loaded
class FeedbacksLoaded extends FeedbackState {
  final List<FeedBackModel> feedbacks;
  final double rating;
  final int numberOfFeedbacks;

  FeedbacksLoaded(this.feedbacks, this.rating, this.numberOfFeedbacks);

  @override
  List<Object> get props => [feedbacks, rating, numberOfFeedbacks];
}

/// Feedbacks wasn't loaded
class FeedbacksLoadFailure extends FeedbackState {
  final String error;

  FeedbacksLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
