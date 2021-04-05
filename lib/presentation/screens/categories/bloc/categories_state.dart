import 'package:e_commerce_app/presentation/screens/categories/bloc/categories_bloc.dart';
import 'package:equatable/equatable.dart';

class CategoriesState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Display list products
class DisplayListProducts extends CategoriesState {
  final PriceSegment? priceSegment;
  final bool loading;
  final String msg;

  DisplayListProducts({
    this.priceSegment,
    required this.loading,
    required this.msg,
  });

  factory DisplayListProducts.loading() {
    return DisplayListProducts(
      msg: "",
      priceSegment: null,
      loading: true,
    );
  }

  factory DisplayListProducts.data(
    PriceSegment priceSegment,
  ) {
    return DisplayListProducts(
      msg: "",
      priceSegment: priceSegment,
      loading: false,
    );
  }

  factory DisplayListProducts.error(String msg) {
    return DisplayListProducts(
      msg: msg,
      priceSegment: null,
      loading: false,
    );
  }

  @override
  List<Object?> get props => [priceSegment, loading, msg];
}

/// Update toolbar
class UpdateToolbarState extends CategoriesState {
  final bool showSearchField;

  UpdateToolbarState({required this.showSearchField});

  @override
  List<Object?> get props => [showSearchField];

  @override
  String toString() {
    return 'UpdateSearchIconState{showSearchIcon: $showSearchField}';
  }
}

/// Open sort option dialog
class OpenSortOption extends CategoriesState {
  final bool isOpen;
  final ProductSortOption currSortOption;

  OpenSortOption({required this.isOpen, required this.currSortOption});

  @override
  List<Object?> get props =>
      [isOpen, currSortOption, DateTime.now().millisecond];

  @override
  String toString() {
    return 'OpenSortOption{isOpen: $isOpen, showSortBy: ${currSortOption.toString()}}';
  }
}
