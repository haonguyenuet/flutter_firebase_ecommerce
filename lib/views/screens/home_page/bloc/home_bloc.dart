import 'package:e_commerce_app/business_logic/entities/banner.dart';
import 'package:e_commerce_app/business_logic/entities/category.dart';
import 'package:e_commerce_app/business_logic/entities/product.dart';
import 'package:e_commerce_app/business_logic/repository/banner_repository/banner_repo.dart';
import 'package:e_commerce_app/business_logic/repository/product_repository/product_repo.dart';
import 'package:e_commerce_app/views/screens/home_page/bloc/home_event.dart';
import 'package:e_commerce_app/views/screens/home_page/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final BannerRepository _bannerRepository;
  final ProductRepository _productRepository;

  HomeBloc(
      {@required BannerRepository bannerRepository,
      @required ProductRepository productRepository})
      : assert(bannerRepository != null),
        assert(productRepository != null),
        _bannerRepository = bannerRepository,
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
        products: await _productRepository.getProducts(),
      );
      yield HomeLoaded(homeResponse: homeResponse);
    } catch (e) {
      yield HomeLoadFailure(e);
    }
  }
}

class HomeResponse {
  final List<Product> products;
  final List<Category> categories;
  final List<BannerItem> banners;

  HomeResponse({
    this.banners,
    this.products,
    this.categories,
  });
}
