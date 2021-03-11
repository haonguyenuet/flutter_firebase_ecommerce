import 'package:e_commerce_app/business_logic/entities/banner.dart';
import 'package:e_commerce_app/business_logic/entities/category.dart';
import 'package:e_commerce_app/business_logic/entities/product.dart';
import 'package:e_commerce_app/business_logic/repository/banner_repository/banner_repo.dart';
import 'package:e_commerce_app/business_logic/repository/product_repository/product_repo.dart';
import 'package:e_commerce_app/presentation/screens/home_page/bloc/home_event.dart';
import 'package:e_commerce_app/presentation/screens/home_page/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final BannerRepository _bannerRepository;
  final ProductRepository _productRepository;

  HomeBloc(
      {required BannerRepository bannerRepository,
      required ProductRepository productRepository})
      : _bannerRepository = bannerRepository,
        _productRepository = productRepository,
        super(HomeLoading());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is LoadHome) {
      yield* _mapLoadHomeToState();
    } else if (event is RefreshHome) {
      yield HomeLoading();
      yield* _mapLoadHomeToState();
    }
  }

  Stream<HomeState> _mapLoadHomeToState() async* {
    try {
      HomeResponse homeResponse = HomeResponse(
        banners: await _bannerRepository.getBanners(),
        categories: await _productRepository.getCategories(),
        popularProducts: await _productRepository.getPopularProducts(),
        discountProducts: await _productRepository.getDiscountProducts(),
      );
      yield HomeLoaded(homeResponse: homeResponse);
    } catch (e) {
      yield HomeLoadFailure(e.toString());
    }
  }
}

class HomeResponse {
  final List<Product> popularProducts;
  final List<Product> discountProducts;
  final List<Category> categories;
  final List<BannerItem> banners;

  HomeResponse({
    required this.banners,
    required this.popularProducts,
    required this.categories,
    required this.discountProducts,
  });
}
