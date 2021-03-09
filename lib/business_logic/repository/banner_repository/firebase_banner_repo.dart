import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/business_logic/entities/banner.dart';

import 'package:e_commerce_app/business_logic/repository/banner_repository/banner_repo.dart';

/// Cart is collection in each user
class FirebaseBannerRepository implements BannerRepository {
  @override
  Future<List<BannerItem>> getBanners() async {
    return await FirebaseFirestore.instance
        .collection("banners")
        .get()
        .then((snapshot) => snapshot.docs
            .map((doc) => BannerItem.fromMap(doc.data()!))
            .toList())
        .catchError((err) {});
  }
}
