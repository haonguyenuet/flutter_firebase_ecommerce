/// Product model
class Product {
  /// Product id
  final String id;

  /// CategoryModel id
  final String categoryId;

  /// Product name
  final String name;

  /// Product description
  final String description;

  /// Product preview images
  final List<dynamic> images;

  /// Product rating
  final dynamic rating;

  /// Product quantity and sold quantity
  final int quantity, soldQuantity;

  /// Original price and percent-off sale
  final int originalPrice, percentOff;

  /// Is available
  final bool isAvailable;

  /// Get current price
  int get price => (this.originalPrice * (100 - this.percentOff) / 100).ceil();

  /// Constructor
  Product({
    required this.id,
    required this.images,
    required this.rating,
    required this.isAvailable,
    required this.quantity,
    required this.categoryId,
    required this.name,
    required this.originalPrice,
    required this.percentOff,
    required this.soldQuantity,
    required this.description,
  });

  /// Json data from server turns into model data
  static Product fromMap(String id, Map<String, dynamic> data) {
    return Product(
      id: data["id"] ?? "",
      name: data["name"] ?? "",
      description: data["description"] ?? "",
      images: data["images"] ?? [],
      categoryId: data["categoryId"] ?? "",
      quantity: data["quantity"] ?? 0,
      soldQuantity: data["soldQuantity"] ?? 0,
      rating: data["rating"] ?? 0.0,
      isAvailable: data["isAvailable"] ?? true,
      percentOff: data["percentOff"] ?? 0,
      originalPrice: data["originalPrice"] ?? 0,
    );
  }

  /// Clone and update a product
  Product cloneWith({
    id,
    name,
    description,
    images,
    categoryId,
    rating,
    isAvailable,
    quantity,
    soldQuantity,
    percentOff,
    originalPrice,
    price,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      images: images ?? this.images,
      categoryId: categoryId ?? this.categoryId,
      quantity: quantity ?? this.quantity,
      soldQuantity: soldQuantity ?? this.soldQuantity,
      rating: rating ?? this.rating,
      isAvailable: isAvailable ?? this.isAvailable,
      percentOff: percentOff ?? this.percentOff,
      originalPrice: originalPrice ?? this.originalPrice,
    );
  }
}
