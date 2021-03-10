import 'package:e_commerce_app/business_logic/entities/category.dart';
import 'package:equatable/equatable.dart';
import 'package:e_commerce_app/views/screens/all_products/bloc/bloc.dart';

class AllProductsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OpenScreen extends AllProductsEvent {
  final Category? category;

  OpenScreen(this.category);

  @override
  List<Object?> get props => [category];

  @override
  String toString() {
    return 'OpenScreen{category: $category}';
  }
}

class ClickIconSearch extends AllProductsEvent {}

class ClickCloseSearch extends AllProductsEvent {}

class SearchQueryChanged extends AllProductsEvent {
  final String keyword;

  SearchQueryChanged(this.keyword);

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
    return 'CategoryChanged{category: $category}';
  }
}

class ClickIconSort extends AllProductsEvent {
  @override
  List<Object> get props => [DateTime.now().millisecond];
}

class CloseSortOption extends AllProductsEvent {
  @override
  List<Object> get props => [DateTime.now().millisecond];
}

class SortOptionsChanged extends AllProductsEvent {
  final ProductSortOption productSortOption;

  SortOptionsChanged(this.productSortOption);

  @override
  List<Object> get props => [productSortOption];

  @override
  String toString() {
    return 'SortByChanged{showSortBy: $productSortOption}';
  }
}
