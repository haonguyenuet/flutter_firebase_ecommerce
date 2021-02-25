import 'package:e_commerce_app/business_logic/entities/banner.dart';
import 'package:e_commerce_app/business_logic/entities/category.dart';
import 'package:e_commerce_app/business_logic/entities/product.dart';
import 'package:e_commerce_app/business_logic/services/abstract/i_banner_service.dart';
import 'package:e_commerce_app/business_logic/services/abstract/i_category_service.dart';
import 'package:e_commerce_app/business_logic/services/abstract/i_product_service.dart';
import 'package:e_commerce_app/business_logic/services/banner_service.dart';
import 'package:e_commerce_app/business_logic/services/category_service.dart';
import 'package:e_commerce_app/business_logic/services/product_service.dart';

class HomeRepository {
  final IProductService _productService = ProductService();
  final ICategoryService _categoryService = CategoryService();
  final IBannerService _bannerService = BannerService();

  Future<HomeResponse> getHomeData() async {
    List<Product> products = await _productService.getProducts() ?? [];
    List<Category> categories = await _categoryService.getCategories() ?? [];
    List<BannerItem> banners = await _bannerService.getBanners() ?? [];
    return HomeResponse(
      products: products,
      categories: categories,
      banners: banners,
    );
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
