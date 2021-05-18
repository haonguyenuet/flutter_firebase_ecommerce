import 'package:equatable/equatable.dart';

class LocationModel extends Equatable {
  final int id;
  final String name;

  LocationModel({this.id = 0, this.name = ""});

  static LocationModel fromMap(Map<String, dynamic> data) {
    return LocationModel(
      id: data["ID"] ?? 0,
      name: data["Title"] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "ID": this.id,
      "Title": this.name,
    };
  }

  @override

  List<Object> get props => [id, name];
}
