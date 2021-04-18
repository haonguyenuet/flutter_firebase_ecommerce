import 'package:equatable/equatable.dart';

/// Category model
class Category extends Equatable {
  final String id;
  final String name;
  final String imageUrl;

  const Category({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  /// Json data from server turns into model data
  static Category fromMap(String id, Map<String, dynamic> data) {
    return Category(
      id: data["id"] ?? "",
      name: data["name"] ?? "",
      imageUrl: data["imageUrl"] ?? "",
    );
  }

  /// From model data turns into json data => server
  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "name": this.name,
      "imageUrl": this.imageUrl,
    };
  }

  /// Represent to all category
  static const all = Category(
    id: "default",
    name: "All products",
    imageUrl: "",
  );

  @override
  String toString() {
    return this.name;
  }

  @override
  List<Object?> get props => [this.id];
}
