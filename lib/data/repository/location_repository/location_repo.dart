import 'package:e_commerce_app/data/models/error_model.dart';
import 'package:e_commerce_app/data/models/location_model.dart';
import 'package:e_commerce_app/data/request/api_url.dart';
import 'package:e_commerce_app/data/request/request.dart';

class LocationRepository {
  Request _request = Request(baseUrl: LocationApi.BASE_URL);

  Future<List<LocationModel>> fetchCities() async {
    List<LocationModel> citites = [];

    String url = "/city";
    var res = await _request.requestApi(method: MethodType.GET, url: url);

    if (res is ErrorModel) return citites;

    var data = (res as Map<String, dynamic>);
    var results = data["LtsItem"] as List<dynamic>;
    citites = results.map((item) => LocationModel.fromMap(item)).toList();
    return citites;
  }

  Future<List<LocationModel>> fetchDistricts(int cityId) async {
    List<LocationModel> districts = [];

    String url = "/city/$cityId/district";
    var res = await _request.requestApi(method: MethodType.GET, url: url);

    if (res is ErrorModel) return districts;

    var data = (res as List<dynamic>);
    districts = data.map((item) => LocationModel.fromMap(item)).toList();
    return districts;
  }

  Future<List<LocationModel>> fetchWards(int districtId) async {
    List<LocationModel> wards = [];

    String url = "/district/$districtId/ward";
    var res = await _request.requestApi(method: MethodType.GET, url: url);

    if (res is ErrorModel) return wards;

    var data = (res as List<dynamic>);

    wards = data.map((item) => LocationModel.fromMap(item)).toList();
    return wards;
  }
}
