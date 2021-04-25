import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/data/entities/cart_item.dart';
import 'package:e_commerce_app/data/entities/delivery_address.dart';
import 'package:equatable/equatable.dart';

class Order extends Equatable {
  final String id;
  final String uid;
  final List<OrderItem> items;
  final String paymentMethod;
  final DeliveryAddress deliveryAddress;
  final int priceToBePaid;
  final int priceOfGoods;
  final int deliveryFee;
  final int coupon;
  final Timestamp createdAt;

  bool get isDelivering {
    var now = Timestamp.now();
    return now.compareTo(receivedDate) < 0;
  }

  Timestamp get receivedDate =>
      Timestamp.fromDate(this.createdAt.toDate().add(Duration(days: 3)));

  Order({
    required this.id,
    required this.uid,
    required this.items,
    required this.deliveryAddress,
    required this.paymentMethod,
    required this.priceToBePaid,
    required this.priceOfGoods,
    required this.deliveryFee,
    required this.coupon,
    required this.createdAt,
  });

  /// Json data from server turns into model data
  static Order fromMap(Map<String, dynamic> data) {
    return Order(
      id: data["id"],
      uid: data["uid"],
      items: List<OrderItem>.from(data["items"]!.map((item) {
        return OrderItem.fromMap(item);
      })),
      deliveryAddress: DeliveryAddress.fromMap(data["deliveryAddress"]),
      paymentMethod: data["paymentMethod"],
      priceToBePaid: data["priceToBePaid"],
      priceOfGoods: data["priceOfGoods"],
      deliveryFee: data["deliveryFee"],
      coupon: data["coupon"],
      createdAt: data["createdAt"],
    );
  }

  /// From model data turns into json data => server
  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "uid": this.uid,
      "items": List<dynamic>.from(this.items.map((item) => item.toMap())),
      "deliveryAddress": this.deliveryAddress.toMap(),
      "paymentMethod": this.paymentMethod,
      "priceToBePaid": this.priceToBePaid,
      "priceOfGoods": this.priceOfGoods,
      "deliveryFee": this.deliveryFee,
      "coupon": this.coupon,
      "createdAt": this.createdAt,
    };
  }

  /// Clone and update
  Order cloneWith({
    id,
    uid,
    items,
    deliveryAddress,
    paymentMethod,
    priceToBePaid,
    priceOfGoods,
    deliveryFee,
    coupon,
    createdAt,
  }) {
    return Order(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      items: items ?? this.items,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      priceToBePaid: priceToBePaid ?? this.priceToBePaid,
      priceOfGoods: priceOfGoods ?? this.priceOfGoods,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      coupon: coupon ?? this.coupon,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        uid,
        items,
        deliveryAddress,
        paymentMethod,
        priceOfGoods,
        deliveryFee,
        coupon,
        createdAt,
      ];
}

class OrderItem {
  final String productId;

  final String productName;

  final int productPrice;

  final String productImage;

  final int quantity;

  /// Constructor
  OrderItem({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.quantity,
  });

  /// Json data from server turns into model data
  static OrderItem fromMap(Map<String, dynamic> data) {
    return OrderItem(
      productId: data["productId"] ?? "",
      productImage: data["productImage"] ?? "",
      productName: data["productName"] ?? "",
      productPrice: data["productPrice"] ?? "",
      quantity: data["quantity"] ?? 0,
    );
  }

  /// From model data turns into json data => server
  Map<String, dynamic> toMap() {
    return {
      "productId": this.productId,
      "productName": this.productName,
      "productImage": this.productImage,
      "productPrice": this.productPrice,
      "quantity": this.quantity,
    };
  }

  /// Json data from server turns into model data
  static OrderItem fromCartItem(CartItem cartItem) {
    return OrderItem(
      productId: cartItem.productId,
      quantity: cartItem.quantity,
      productImage: cartItem.productInfo!.images[0],
      productName: cartItem.productInfo!.name,
      productPrice: cartItem.productInfo!.price,
    );
  }
}
