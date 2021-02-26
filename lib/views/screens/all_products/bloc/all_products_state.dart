import 'package:e_commerce_app/business_logic/entities/category.dart';
import 'package:e_commerce_app/business_logic/entities/product.dart';
import 'package:equatable/equatable.dart';

class AllProductsState extends Equatable {
  @override
  List<Object> get props => [];
}

/// Categories Loading
class CategoriesLoading extends AllProductsState {}

/// Adready categories data
class CategoriesLoaded extends AllProductsState {
  final List<Category> categories;

  CategoriesLoaded({this.categories});

  @override
  List<Object> get props => [categories];

  @override
  String toString() {
    return 'CategoriesLoaded{response: ${categories.length}}';
  }
}

/// Failure
class CategoriesLoadFailure extends AllProductsState {
  final String error;

  CategoriesLoadFailure(this.error);

  @override
  String toString() {
    return 'HomeLoadFailure{e: $error}';
  }
}

/// Display list products
class DisplayListProducts extends AllProductsState {
  final List<Product> productsByCategory;
  final bool loading;
  final String msg;

  DisplayListProducts({this.productsByCategory, this.loading, this.msg});

  factory DisplayListProducts.loading() {
    return DisplayListProducts(
      msg: "",
      productsByCategory: [],
      loading: true,
    );
  }

  factory DisplayListProducts.data(List<Product> productsByCategory) {
    return DisplayListProducts(
      msg: "",
      productsByCategory: productsByCategory,
      loading: false,
    );
  }

  factory DisplayListProducts.error(String msg) {
    return DisplayListProducts(
      msg: msg,
      productsByCategory: [],
      loading: false,
    );
  }

  @override
  List<Object> get props => [productsByCategory, loading, msg];

  @override
  String toString() {
    return 'DisplayListProducts{productsByCategory: ${productsByCategory.length}, loading: $loading, msg: $msg}';
  }
}

/// Update toolbar
class UpdateToolbarState extends AllProductsState {
  final bool showSearchField;

  UpdateToolbarState({this.showSearchField});

  @override
  List<Object> get props => [showSearchField];

  @override
  String toString() {
    return 'UpdateSearchIconState{showSearchIcon: $showSearchField}';
  }
}

// class OpenSortOption extends AllProductsState {
//   final bool isOpen;
//   final SHOW_SORT_BY showSortBy;

//   OpenSortOption({this.isOpen, this.showSortBy});

//   @override
//   List<Object> get props => [isOpen, showSortBy, DateTime.now().millisecond];

//   @override
//   String toString() {
//     return 'OpenSortOption{isOpen: $isOpen, showSortBy: $showSortBy}';
//   }
// }
