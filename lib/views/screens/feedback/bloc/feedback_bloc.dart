import 'dart:async';

import 'package:e_commerce_app/business_logic/entities/entites.dart';
import 'package:e_commerce_app/business_logic/repository/repository.dart';
import 'package:e_commerce_app/views/screens/feedback/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  final FeedbackRepository _feedbackRepository;
  final ProductRepository _productRepository;
  StreamSubscription _feedbackSubscription;
  Product _currentProduct;
  double _currAverageRating = 0.0;

  FeedbackBloc({
    @required FeedbackRepository feedbackRepository,
    @required ProductRepository productRepository,
  })  : assert(feedbackRepository != null),
        assert(productRepository != null),
        _feedbackRepository = feedbackRepository,
        _productRepository = productRepository,
        super(FeedbacksLoading());

  @override
  Stream<FeedbackState> mapEventToState(FeedbackEvent event) async* {
    if (event is LoadFeedbacks) {
      yield* _mapLoadFeedbackToState(event);
    } else if (event is AddFeedbackItem) {
      yield* _mapAddFeedbackItemToState(event);
    } else if (event is StarChanged) {
      yield* _mapStarChangedToState(event);
    } else if (event is FeedbacksUpdated) {
      yield* _mapFeedbacksUpdatedToState(event);
    }
  }

  Stream<FeedbackState> _mapLoadFeedbackToState(LoadFeedbacks event) async* {
    try {
      _currentProduct = event.product;
      _feedbackSubscription?.cancel();
      _feedbackSubscription =
          _feedbackRepository.feedbackStream(_currentProduct.id).listen(
                (feedback) => add(FeedbacksUpdated(feedback)),
              );
    } catch (e) {
      yield FeedbacksLoadFailure(e);
    }
  }

  Stream<FeedbackState> _mapAddFeedbackItemToState(
      AddFeedbackItem event) async* {
    try {
      _feedbackRepository.addNewFeedback(_currentProduct.id, event.feedback);
    } catch (e) {
      print(e);
    }
  }

  Stream<FeedbackState> _mapStarChangedToState(StarChanged event) async* {
    try {
      yield FeedbacksLoading();
      var feedbacks = await _feedbackRepository.getFeedbacksByStar(
        _currentProduct.id,
        event.star,
      );
      yield FeedbacksLoaded(FeedbacksResponse(
        feedbacks: feedbacks,
        rating: _currAverageRating,
        numberOfFeedbacks: feedbacks.length,
      ));
    } catch (e) {
      print(e);
    }
  }

  Stream<FeedbackState> _mapFeedbacksUpdatedToState(
      FeedbacksUpdated event) async* {
    // Calculate again average product rating
    var totalRating = 0;
    var feedbacks = event.feedbacks;
    feedbacks.forEach((f) => totalRating += f.rating);
    var averageRating =
        feedbacks.length > 0 ? totalRating / feedbacks.length : 0.0;
    _currAverageRating = double.parse(averageRating.toStringAsFixed(1));
    // Update product rating
    _productRepository.updateProductRatingById(
      _currentProduct.id,
      _currAverageRating,
    );
    yield FeedbacksLoaded(FeedbacksResponse(
      feedbacks: feedbacks,
      rating: _currAverageRating,
      numberOfFeedbacks: feedbacks.length,
    ));
  }

  @override
  Future<void> close() {
    _feedbackSubscription?.cancel();
    return super.close();
  }
}

class FeedbacksResponse {
  final List<FeedbackItem> feedbacks;
  final double rating;
  final int numberOfFeedbacks;

  FeedbacksResponse({this.numberOfFeedbacks, this.feedbacks, this.rating});
}
