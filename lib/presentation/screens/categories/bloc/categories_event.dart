import 'package:e_commerce_app/data/models/models.dart';
import 'package:e_commerce_app/presentation/screens/categories/bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class CategoriesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OpenScreen extends CategoriesEvent {
  final CategoryModel category;

  OpenScreen(this.category);

  @override
  List<Object?> get props => [category];

  @override
  String toString() {
    return 'OpenScreen{category: $category}';
  }
}

class ClickIconSearch extends CategoriesEvent {}

class ClickCloseSearch extends CategoriesEvent {}

class SearchQueryChanged extends CategoriesEvent {
  final String keyword;

  SearchQueryChanged(this.keyword);

  @override
  List<Object> get props => [keyword];

  @override
  String toString() {
    return 'SearchQueryChanged{keyword: $keyword}';
  }
}

class ClickIconSort extends CategoriesEvent {
  @override
  List<Object> get props => [DateTime.now().millisecond];
}

class CloseSortOption extends CategoriesEvent {
  @override
  List<Object> get props => [DateTime.now().millisecond];
}

class SortOptionsChanged extends CategoriesEvent {
  final ProductSortOption productSortOption;

  SortOptionsChanged(this.productSortOption);

  @override
  List<Object> get props => [productSortOption];

  @override
  String toString() {
    return 'SortByChanged{showSortBy: $productSortOption}';
  }
}
