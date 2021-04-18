import 'package:equatable/equatable.dart';

class DeliveryAddress extends Equatable {
  final String id;

  final String receiverName;

  final String phoneNumber;

  final String detailAddress;

  final bool isDefault;

  /// Constructor
  DeliveryAddress({
    required this.id,
    required this.receiverName,
    required this.phoneNumber,
    required this.detailAddress,
    required this.isDefault,
  });

  /// Json data from server turns into model data
  static DeliveryAddress fromMap(Map<String, dynamic> data) {
    return DeliveryAddress(
      id: data["id"] ?? "",
      phoneNumber: data["phoneNumber"] ?? "",
      receiverName: data["receiverName"] ?? "",
      detailAddress: data["detailAddress"] ?? "",
      isDefault: data["isDefault"] ?? false,
    );
  }

  /// From model data turns into json data => server
  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "phoneNumber": this.phoneNumber,
      "receiverName": this.receiverName,
      "detailAddress": this.detailAddress,
      "isDefault": this.isDefault,
    };
  }

  /// Clone and update
  DeliveryAddress cloneWith({
    id,
    receiverName,
    phoneNumber,
    detailAddress,
    isDefault,
  }) {
    return DeliveryAddress(
      id: id ?? this.id,
      receiverName: receiverName ?? this.receiverName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      detailAddress: detailAddress ?? this.detailAddress,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  @override
  String toString() {
    return "${this.receiverName}, ${this.phoneNumber}\n${this.detailAddress}";
  }

  @override
  List<Object> get props =>
      [id, receiverName, phoneNumber, detailAddress, isDefault];
}
