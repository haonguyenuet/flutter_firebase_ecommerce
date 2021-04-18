import 'package:e_commerce_app/data/entities/banner.dart';

abstract class BannerRepository {
// Get all cart items
  Future<List<BannerItem>> getBanners();
}
