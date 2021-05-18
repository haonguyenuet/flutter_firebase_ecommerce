class DevEnvironment {
  final receiveTimeout = 2 * 60 * 1000;
  final connectTimeout = 2 * 60 * 1000;
}

class LocationApi {
  static const BASE_URL = "https://thongtindoanhnghiep.co/api";
}

final environment = DevEnvironment();

enum MethodType { GET, POST }
