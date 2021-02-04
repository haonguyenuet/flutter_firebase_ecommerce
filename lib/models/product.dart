import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name, description;
  final List<dynamic> images;
  final double rating;
  final int price;
  final int quantity;
  bool isFavourite, isPopular;
  double totalRates, counterRate;
  List<String> feedbacks;
  String type;

  Product({
    @required this.id,
    @required this.images,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    @required this.quantity,
    @required this.type,
    @required this.name,
    @required this.price,
    @required this.description,
  });

  static Product fromDoc(QueryDocumentSnapshot doc) {
    var data = doc.data();
    return Product(
      id: doc.id,
      name: data["name"],
      description: data["desc"],
      price: data["price"],
      isFavourite: data["isFavourite"],
      images: data["images"],
      type: data["type"],
      quantity: data["quantity"],
    );
  }
}
// // Our demo Products
