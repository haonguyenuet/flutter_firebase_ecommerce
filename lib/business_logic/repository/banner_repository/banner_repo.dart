import 'package:e_commerce_app/business_logic/entities/banner.dart';

abstract class BannerRepository {
// Get all cart items
  Future<List<BannerItem>> getBanners();
}
