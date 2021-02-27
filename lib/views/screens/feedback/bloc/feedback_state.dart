import 'package:e_commerce_app/views/screens/feedback/bloc/bloc.dart';
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
  final FeedbacksResponse feedbackResponse;

  FeedbacksLoaded(this.feedbackResponse);

  @override
  List<Object> get props => [feedbackResponse];
}

/// Feedbacks wasn't loaded
class FeedbacksLoadFailure extends FeedbackState {
  final String error;

  FeedbacksLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
