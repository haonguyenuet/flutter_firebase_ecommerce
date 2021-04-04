import 'dart:async';
import 'package:e_commerce_app/business_logic/entities/entites.dart';
import 'package:e_commerce_app/business_logic/repository/app_repository.dart';
import 'package:e_commerce_app/business_logic/repository/repository.dart';
import 'package:e_commerce_app/presentation/screens/categories/bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllProductsBloc extends Bloc<AllProductsEvent, AllProductsState> {
  ProductRepository _productRepository = AppRepository.productRepository;
  // Criteria filters
  late Category _currCategory;
  String _currKeyword = "";
  ProductSortOption _currSortOption = ProductSortOption();

  AllProductsBloc() : super(DisplayListProducts.loading());

  /// Debounce search query changed event
  @override
  Stream<Transition<AllProductsEvent, AllProductsState>> transformEvents(
      Stream<AllProductsEvent> events, transitionFn) {
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
  Stream<AllProductsState> mapEventToState(AllProductsEvent event) async* {
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
  Stream<AllProductsState> _mapOpenScreenToState(Category category) async* {
    try {
      // Set _currCategory
      _currCategory = category;
      // Get products by category
      var products =
          await _productRepository.getProductsByCategory(_currCategory.id);
      yield DisplayListProducts.data(products);
    } catch (e) {
      yield DisplayListProducts.error(e.toString());
    }
  }

  /// Search query changed => state
  Stream<AllProductsState> _mapSearchQueryChangedToState(
      String keyword) async* {
    yield DisplayListProducts.loading();
    try {
      _currKeyword = keyword;
      yield DisplayListProducts.data(await getProducts());
    } catch (e) {
      yield DisplayListProducts.error(e.toString());
    }
  }

  /// Sort option changed => state
  Stream<AllProductsState> _mapSortOptionsChangedToState(
      ProductSortOption productSortOption) async* {
    _currSortOption = productSortOption;
    yield UpdateToolbarState(showSearchField: false);
    yield* _mapSearchQueryChangedToState("");
  }

  /// This should be done at server side
  Future<List<Product>> getProducts() async {
    // Get products by current category
    var products =
        await _productRepository.getProductsByCategory(_currCategory.id);

    // Filter products by current keyword
    bool query(Product p) =>
        _currKeyword.isEmpty ||
        p.name.toLowerCase().contains(_currKeyword.toLowerCase());
    products = products.where(query).toList();

    // Sort
    products.sort(mapOptionToSortMethod() as int Function(Product, Product)?);

    return products;
  }

  /// Map sort options
  Function mapOptionToSortMethod() {
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
