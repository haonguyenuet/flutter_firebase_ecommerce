import 'dart:async';
import 'package:e_commerce_app/data/entities/entites.dart';
import 'package:e_commerce_app/data/repository/app_repository.dart';
import 'package:e_commerce_app/data/repository/repository.dart';
import 'package:e_commerce_app/presentation/screens/categories/bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  ProductRepository _productRepository = AppRepository.productRepository;
  late Category _category;
  // Criteria filters
  String _currKeyword = "";
  ProductSortOption _currSortOption = ProductSortOption();

  CategoriesBloc() : super(DisplayListProducts.loading());

  /// Debounce search query changed event
  @override
  Stream<Transition<CategoriesEvent, CategoriesState>> transformEvents(
      Stream<CategoriesEvent> events, transitionFn) {
    var debounceStream = events
        .where((event) => event is SearchQueryChanged)
        .debounceTime(Duration(milliseconds: 300));
    var nonDebounceStream =
        events.where((event) => event is! SearchQueryChanged);
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

  int sortSoldQuantityDescending(Product a, Product b) =>
      b.soldQuantity.compareTo(a.soldQuantity);
  int sortSoldQuantityAscending(Product a, Product b) =>
      a.soldQuantity.compareTo(b.soldQuantity);
  int sortPriceDescending(Product a, Product b) => b.price.compareTo(a.price);
  int sortPriceAscending(Product a, Product b) => a.price.compareTo(b.price);

  @override
  Stream<CategoriesState> mapEventToState(CategoriesEvent event) async* {
    if (event is OpenScreen) {
      yield UpdateToolbarState(showSearchField: false);
      yield* _mapOpenScreenToState(event.category);
    } else if (event is SearchQueryChanged) {
      yield* _mapSearchQueryChangedToState(event.keyword);
    } else if (event is SortOptionsChanged) {
      yield* _mapSortOptionsChangedToState(event.productSortOption);
    } else if (event is ClickIconSort) {
      yield OpenSortOption(isOpen: true, currSortOption: _currSortOption);
    } else if (event is CloseSortOption) {
      yield OpenSortOption(isOpen: false, currSortOption: _currSortOption);
    } else if (event is ClickIconSearch) {
      yield UpdateToolbarState(showSearchField: true);
    } else if (event is ClickCloseSearch) {
      yield UpdateToolbarState(showSearchField: false);
      yield* _mapSearchQueryChangedToState("");
    }
  }

  /// Open screen event => state
  Stream<CategoriesState> _mapOpenScreenToState(Category category) async* {
    try {
      _category = category;
      yield DisplayListProducts.data(await getProducts());
    } catch (e) {
      yield DisplayListProducts.error(e.toString());
    }
  }

  /// Search query changed => state
  Stream<CategoriesState> _mapSearchQueryChangedToState(String keyword) async* {
    yield DisplayListProducts.loading();
    try {
      _currKeyword = keyword;
      yield DisplayListProducts.data(await getProducts());
    } catch (e) {
      yield DisplayListProducts.error(e.toString());
    }
  }

  /// Sort option changed => state
  Stream<CategoriesState> _mapSortOptionsChangedToState(
      ProductSortOption productSortOption) async* {
    _currSortOption = productSortOption;

    yield UpdateToolbarState(showSearchField: false);

    yield* _mapSearchQueryChangedToState("");
  }

  /// This should be done at server side
  Future<PriceSegment> getProducts() async {
    // Get products by category
    List<Product> productsByCategory =
        await _productRepository.getProductsByCategory(_category.id);
    // Filter products by current keyword
    bool query(Product p) =>
        _currKeyword.isEmpty ||
        p.name.toLowerCase().contains(_currKeyword.toLowerCase());
    productsByCategory = productsByCategory.where(query).toList();

    // Sort
    productsByCategory.sort(_mapOptionToSortMethod());

    // Products are classified according to price segments
    List<Product> productsInLowRange = [];
    List<Product> productsInMidRange = [];
    List<Product> productsInHighRange = [];

    productsByCategory.forEach((product) {
      if (product.price <= PriceSegment.LOW_SEGMENT) {
        productsInLowRange.add(product);
      } else if (product.price > PriceSegment.LOW_SEGMENT &&
          product.price <= PriceSegment.HIGH_SEGMENT) {
        productsInMidRange.add(product);
      } else {
        productsInHighRange.add(product);
      }
    });

    return PriceSegment(
      productsInLowRange: productsInLowRange,
      productsInMidRange: productsInMidRange,
      productsInHighRange: productsInHighRange,
    );
  }

  /// Map sort options
  int Function(Product, Product) _mapOptionToSortMethod() {
    if (_currSortOption.productSortBy == PRODUCT_SORT_BY.SOLD_QUANTITY &&
        _currSortOption.productSortOrder == PRODUCT_SORT_ORDER.DESCENDING) {
      return sortSoldQuantityDescending;
    }
    if (_currSortOption.productSortBy == PRODUCT_SORT_BY.SOLD_QUANTITY &&
        _currSortOption.productSortOrder == PRODUCT_SORT_ORDER.ASCENDING) {
      return sortSoldQuantityAscending;
    }
    if (_currSortOption.productSortBy == PRODUCT_SORT_BY.PRICE &&
        _currSortOption.productSortOrder == PRODUCT_SORT_ORDER.DESCENDING) {
      return sortPriceDescending;
    }
    if (_currSortOption.productSortBy == PRODUCT_SORT_BY.PRICE &&
        _currSortOption.productSortOrder == PRODUCT_SORT_ORDER.ASCENDING) {
      return sortPriceAscending;
    }
    return sortSoldQuantityDescending;
  }

  @override
  Future<void> close() {
    return super.close();
  }
}

// Products by price segment
class PriceSegment {
  static const LOW_SEGMENT = 1000000;
  static const HIGH_SEGMENT = 4000000;

  final List<Product> productsInLowRange;
  final List<Product> productsInMidRange;
  final List<Product> productsInHighRange;

  PriceSegment({
    required this.productsInLowRange,
    required this.productsInMidRange,
    required this.productsInHighRange,
  });
}

/// Product sort options
class ProductSortOption {
  final PRODUCT_SORT_BY? productSortBy;
  final PRODUCT_SORT_ORDER productSortOrder;

  ProductSortOption({
    this.productSortBy,
    this.productSortOrder = PRODUCT_SORT_ORDER.DESCENDING,
  });

  ProductSortOption update({productSortBy, productSortOrder}) {
    return ProductSortOption(
      productSortBy: productSortBy ?? this.productSortBy,
      productSortOrder: productSortOrder ?? this.productSortOrder,
    );
  }

  @override
  String toString() {
    return "ProductSortOption: ${this.productSortBy}, ${this.productSortOrder}";
  }
}

enum PRODUCT_SORT_BY { PRICE, SOLD_QUANTITY }
enum PRODUCT_SORT_ORDER { ASCENDING, DESCENDING }
