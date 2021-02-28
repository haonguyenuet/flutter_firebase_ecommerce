import 'dart:async';

import 'package:e_commerce_app/business_logic/entities/category.dart';
import 'package:e_commerce_app/business_logic/entities/product.dart';
import 'package:e_commerce_app/business_logic/repository/product_repository/product_repo.dart';
import 'package:e_commerce_app/views/screens/all_products/bloc/all_products_event.dart';
import 'package:e_commerce_app/views/screens/all_products/bloc/all_products_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllProductsBloc extends Bloc<AllProductsEvent, AllProductsState> {
  ProductRepository _productRepository;
  Category _currCategory;
  String _currKeyword = "";

  AllProductsBloc({@required ProductRepository productRepository})
      : assert(productRepository != null),
        _productRepository = productRepository,
        super(DisplayListProducts.loading());

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

  int sortByName(Product a, Product b) => a.name.compareTo(b.name);

  int sortByRating(Product a, Product b) => b.rating.compareTo(a.rating);

  @override
  Stream<AllProductsState> mapEventToState(AllProductsEvent event) async* {
    if (event is OpenScreen) {
      yield* _mapOpenScreenToState(event.category);
    } else if (event is SearchQueryChanged) {
      yield* _mapSearchQueryChangedToState(event.keyword);
    } else if (event is CategoryChanged) {
      yield* _mapCategoryChangedToState(event.category);
    }
  }

  /// Open screen event => state
  Stream<AllProductsState> _mapOpenScreenToState(Category category) async* {
    try {
      yield CategoriesLoading();
      // Get categories
      var categories = await _productRepository.getCategories() ?? [];
      var selectedCategoryIndex = 0;
      if (category != null) {
        for (int i = 0; i < categories.length; i++) {
          if (categories[i].cid == category.cid) selectedCategoryIndex = i;
        }
      }
      yield CategoriesLoaded(
        categories: categories,
        selectedCategoryIndex: selectedCategoryIndex,
      );
      // Set _currCategory
      _currCategory = category == null ? categories[0] : category;
      // Get products by category
      var products =
          await _productRepository.getProductsByCategory(_currCategory.cid);
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

  /// Category changed => state
  Stream<AllProductsState> _mapCategoryChangedToState(
      Category category) async* {
    try {
      _currCategory = category;
      yield DisplayListProducts.data(await getProducts());
    } catch (e) {
      yield DisplayListProducts.error(e.toString());
    }
  }

  /// This should be execute at server side
  Future<List<Product>> getProducts() async {
    // Get products by current category
    var products =
        await _productRepository.getProductsByCategory(_currCategory.cid);

    // Filter products by current keyword
    bool query(Product p) =>
        _currKeyword.isEmpty ||
        p.name.toLowerCase().contains(_currKeyword.toLowerCase());

    products = products.where(query).toList();
    return products;
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
