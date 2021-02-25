import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/business_logic/entities/banner.dart';
import 'package:e_commerce_app/business_logic/services/abstract/i_banner_service.dart';

/// Cart is collection in each user
class BannerService extends IBannerService {
  @override
  Future<List<BannerItem>> getBanners() async {
    return await FirebaseFirestore.instance
        .collection("banners")
        .get()
        .then((snapshot) => snapshot.docs
            .map((doc) => BannerItem.fromMap(doc.id, doc.data()))
            .toList())
        .catchError((err) => print(err));
  }
}
