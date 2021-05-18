import 'package:e_commerce_app/data/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class Searching extends SearchState {}

///
class SuggestionLoaded extends SearchState {
  final List<String> recentKeywords;
  final List<String> hotKeywords;

  SuggestionLoaded({required this.recentKeywords, required this.hotKeywords});

  List<Object> get props => [this.recentKeywords, this.hotKeywords];
}

///
class ResultsLoaded extends SearchState {
  final List<Product> results;

  ResultsLoaded(this.results);

  List<Object> get props => [this.results];
}

///
class SearchFailure extends SearchState {
  final String error;

  SearchFailure(this.error);

  List<Object> get props => [this.error];
}
