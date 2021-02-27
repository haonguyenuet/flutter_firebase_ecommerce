import 'package:e_commerce_app/business_logic/entities/category.dart';
import 'package:equatable/equatable.dart';

class AllProductsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class OpenScreen extends AllProductsEvent {
  final Category category;

  OpenScreen(this.category);

  @override
  List<Object> get props => [category];

  @override
  String toString() {
    return 'OpenScreen{keyword: $category}';
  }
}

class SearchQueryChanged extends AllProductsEvent {
  final String keyword;

  SearchQueryChanged({this.keyword});

  @override
  List<Object> get props => [keyword];

  @override
  String toString() {
    return 'SearchQueryChanged{keyword: $keyword}';
  }
}

class CategoryChanged extends AllProductsEvent {
  final Category category;

  CategoryChanged(this.category);

  @override
  List<Object> get props => [category];

  @override
  String toString() {
    return 'CategoryChanged{keyword: $category}';
  }
}

// class SortByChanged extends AllShowsEvent {
//   SHOW_SORT_BY showSortBy;

//   SortByChanged(this.showSortBy);

//   @override
//   List<Object> get props => [showSortBy];

//   @override
//   String toString() {
//     return 'SortByChanged{showSortBy: $showSortBy}';
//   }
// }
