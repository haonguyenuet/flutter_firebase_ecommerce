import 'package:equatable/equatable.dart';

class BannerItem extends Equatable {
  final String id;
  final String imageUrl;

  BannerItem({required this.id, required this.imageUrl});

  /// Json data from server turns into model data
  static BannerItem fromMap(Map<String, dynamic> data) {
    return BannerItem(
      id: data["id"] ?? "",
      imageUrl: data["imageUrl"] ?? "",
    );
  }

  /// From model data turns into json data => server
  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "name": this.imageUrl,
    };
  }

  @override
  String toString() {
    return 'BannerItem{id: $id, url: $imageUrl}';
  }

  @override
  List<Object?> get props => [id, imageUrl];
}
