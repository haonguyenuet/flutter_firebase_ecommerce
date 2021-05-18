import 'package:e_commerce_app/data/models/models.dart';

abstract class BannerRepository {
// Get all cart items
  Future<List<BannerModel>> fetchBanners();
}
