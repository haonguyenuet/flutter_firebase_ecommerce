import 'package:flutter/material.dart';

class Product {
  // Product id
  final String id;
  // Product name
  final String name;
  // Product description
  final String description;
  // Product preview images
  final List<dynamic> images;
  // Product rating
  final dynamic rating;
  final int quantity, soldQuantity, originalPrice;
  bool isAvailable, isPopular, isSale;
  final String type;

  // Constructor
  Product({
    @required this.id,
    @required this.images,
    @required this.rating,
    this.isAvailable = false,
    this.isPopular = false,
    this.isSale = false,
    @required this.quantity,
    @required this.type,
    @required this.name,
    @required this.originalPrice,
    @required this.soldQuantity,
    @required this.description,
  });

  // Json data from server turns into model data
  static Product fromMap(String id, Map<String, dynamic> data) {
    return Product(
      id: id,
      name: data["name"] ?? "Unknown",
      description: data["desc"] ?? "",
      originalPrice: data["price"] ?? 0,
      isAvailable: data["isAvailable"] ?? true,
      images: data["images"] ?? "",
      type: data["type"] ?? "",
      quantity: data["quantity"] ?? 0,
      rating: data["rating"] ?? 0.0,
      soldQuantity: data["soldQuantity"] ?? 0,
    );
  }

  // Clone and update a product
  Product cloneWith({
    id,
    images,
    isAvailable,
    isPopular,
    isSale,
    totalRating,
    numberOfRating,
    quantity,
    type,
    name,
    originalPrice,
    soldQuantity,
    description,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      originalPrice: originalPrice ?? this.originalPrice,
      isAvailable: isAvailable ?? this.isAvailable,
      images: images ?? this.images,
      type: type ?? this.type,
      quantity: quantity ?? this.quantity,
      rating: rating ?? this.rating,
      soldQuantity: soldQuantity ?? this.soldQuantity,
    );
  }
}
