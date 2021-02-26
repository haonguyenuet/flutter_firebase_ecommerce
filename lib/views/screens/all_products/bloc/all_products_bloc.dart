import 'dart:async';

import 'package:e_commerce_app/business_logic/entities/category.dart';
import 'package:e_commerce_app/business_logic/entities/product.dart';
import 'package:e_commerce_app/business_logic/repository/product_repository/product_repo.dart';
import 'package:e_commerce_app/views/screens/all_products/bloc/all_products_event.dart';
import 'package:e_commerce_app/views/screens/all_products/bloc/all_products_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllProductsBloc extends Bloc<AllProductsEvent, AllProductsState> {
  ProductRepository _productRepository;
  Category _filterCategory;

  AllProductsBloc({@required ProductRepository productRepository})
      : assert(productRepository != null),
        _productRepository = productRepository,
        super(DisplayListProducts.loading());

  int sortByName(Product a, Product b) => a.name.compareTo(b.name);

  int sortByRating(Product a, Product b) => b.rating.compareTo(a.rating);

  @override
  Stream<AllProductsState> mapEventToState(AllProductsEvent event) async* {
    if (event is OpenScreen) {
      yield UpdateToolbarState(showSearchField: false);
      yield* _mapOpenScreenToState(event.category);
    } else if (event is ClickIconSearch) {
      yield UpdateToolbarState(showSearchField: true);
    } else if (event is ClickCloseSearch) {
      yield UpdateToolbarState(showSearchField: false);
      yield* _mapSearchQueryChangedToState("");
    } else if (event is SearchQueryChanged) {
      yield* _mapSearchQueryChangedToState(event.keyword);
    } else if (event is CategoryChanged) {
      yield* _mapCategoryChangedToState(event.category);
    }
  }

  Stream<AllProductsState> _mapOpenScreenToState(Category category) async* {
    try {
      yield CategoriesLoading();
      // Get products by category
      var categories = await _productRepository.getCategories();
      yield CategoriesLoaded(categories: categories);
      // Set _filterCategory
      _filterCategory = category == null ? categories[0] : category;
      // Get products by category
      var products =
          await _productRepository.getProductsByCategory(_filterCategory.cid);
      yield DisplayListProducts.data(products);
    } catch (e) {
      yield DisplayListProducts.error(e.toString());
    }
  }

  Stream<AllProductsState> _mapSearchQueryChangedToState(
      String keyword) async* {
    yield DisplayListProducts.loading();
    try {
      // Get products by category
      var products =
          await _productRepository.getProductsByCategory(_filterCategory.cid);
      // This should be execute at server side
      // Filter products by keyword
      bool query(Product p) =>
          keyword.isEmpty ||
          p.name.toLowerCase().contains(keyword.toLowerCase());

      products = products.where(query).toList();
      yield DisplayListProducts.data(products);
    } catch (e) {
      yield DisplayListProducts.error(e.toString());
    }
  }

  Stream<AllProductsState> _mapCategoryChangedToState(
      Category category) async* {
    try {
      // Set _filterCategory by category from event
      _filterCategory = category;
      var products =
          await _productRepository.getProductsByCategory(category.cid);
      yield DisplayListProducts.data(products);
    } catch (e) {
      yield DisplayListProducts.error(e.toString());
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
