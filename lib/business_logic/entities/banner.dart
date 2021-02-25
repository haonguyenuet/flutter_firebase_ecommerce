import 'package:equatable/equatable.dart';

class BannerItem extends Equatable {
  final String id;
  final String imageUrl;

  BannerItem({this.id, this.imageUrl});

  /// Json data from server turns into model data
  static BannerItem fromMap(String id, Map<String, dynamic> data) {
    return BannerItem(
      id: id,
      imageUrl: data["imageUrl"] ?? "",
    );
  }

  /// From model data turns into json data => server
  Map<String, dynamic> toMap() {
    Map<String, dynamic> bannerData = {
      "id": this.id,
      "name": this.imageUrl,
    };
    return bannerData;
  }

  @override
  List<Object> get props => [id, imageUrl];

  @override
  String toString() {
    return 'BannerItem{id: $id, url: $imageUrl}';
  }
}
