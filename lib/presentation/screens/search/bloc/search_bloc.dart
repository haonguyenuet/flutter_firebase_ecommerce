import 'package:e_commerce_app/data/models/models.dart';
import 'package:e_commerce_app/data/local/pref.dart';
import 'package:e_commerce_app/data/repository/repository.dart';
import 'package:e_commerce_app/presentation/screens/search/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  ProductRepository _productRepository = AppRepository.productRepository;

  SearchBloc() : super(Searching());

  /// Debounce search query changed event
  @override
  Stream<Transition<SearchEvent, SearchState>> transformEvents(
      Stream<SearchEvent> events, transitionFn) {
    var debounceStream = events
        .where((event) => event is KeywordChanged)
        .debounceTime(Duration(milliseconds: 500));
    var nonDebounceStream = events.where((event) => event is! KeywordChanged);
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is OpenScreen) {
      yield* _mapOpenScreenToState();
    } else if (event is KeywordChanged) {
      yield* _mapKeywordChangedToState(event.keyword);
    }
  }

  Stream<SearchState> _mapOpenScreenToState() async* {
    try {
      List<String> recentKeywords = await _getRecentKeywords();
      yield SuggestionLoaded(
        recentKeywords: recentKeywords,
        hotKeywords: hotKeywords,
      );
    } catch (e) {
      yield SearchFailure(e.toString());
    }
  }

  Stream<SearchState> _mapKeywordChangedToState(String keyword) async* {
    yield Searching();
    try {
      List<String> recentKeywords = await _getRecentKeywords();
      if (keyword.isEmpty) {
        yield SuggestionLoaded(
          recentKeywords: recentKeywords,
          hotKeywords: hotKeywords,
        );
      } else {
        // Get products by keywords
        List<Product> products = await _productRepository.fetchProducts();
        List<Product> results = products
            .where((p) => p.name.toLowerCase().contains(keyword.toLowerCase()))
            .toList();
        yield ResultsLoaded(results);
        // Store keyword to local
        if (!recentKeywords.contains(keyword.toLowerCase())) {
          if (recentKeywords.length > 9) {
            recentKeywords.removeAt(0);
          }
          recentKeywords.add(keyword.toLowerCase());
          await LocalPref.setStringList("recentKeywords", recentKeywords);
        }
      }
    } catch (e) {
      yield SearchFailure(e.toString());
    }
  }

  Future<List<String>> _getRecentKeywords() async {
    return LocalPref.getStringList("recentKeywords") ?? [];
  }
}

const List<String> hotKeywords = [
  "Akko",
  "Zarer",
  "Dragon ball",
  "keyboard",
];
