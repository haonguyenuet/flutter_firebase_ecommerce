import 'package:equatable/equatable.dart';

/// Category model
class Category extends Equatable {
  final String cid;
  final String name;
  final String? vietnameseName;
  final String iconPath;

  const Category({
    required this.cid,
    required this.name,
    this.vietnameseName,
    required this.iconPath,
  });

  /// Json data from server turns into model data
  static Category fromMap(String id, Map<String, dynamic> data) {
    return Category(
      cid: id,
      name: data["name"] ?? "",
      vietnameseName: data["vietnameseName"] ?? "",
      iconPath: data["iconPath"] ?? "",
    );
  }

  /// From model data turns into json data => server
  Map<String, dynamic> toMap() {
    Map<String, dynamic> categoryData = {
      "cid": this.cid,
      "name": this.name,
      "vietnameseName": this.vietnameseName,
      "iconPath": this.iconPath,
    };
    return categoryData;
  }

  /// Represent to all category
  static const all = Category(
    cid: "default",
    name: "All",
    vietnameseName: "Tất cả",
    iconPath: "assets/icons/all.svg",
  );

  @override
  List<Object?> get props => [this.cid];
}
