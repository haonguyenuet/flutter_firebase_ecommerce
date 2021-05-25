import 'package:e_commerce_app/data/models/error_model.dart';
import 'package:e_commerce_app/data/models/location_model.dart';
import 'package:e_commerce_app/data/request/api_url.dart';
import 'package:e_commerce_app/data/request/request.dart';

class LocationRepository {
  Request _request = Request(baseUrl: LocationApi.BASE_URL);

  Future<List<LocationModel>> fetchCities() async {
    List<LocationModel> citites = [];

    String url = "/province";
    var res = await _request.requestApi(method: MethodType.GET, url: url);

    if (res is ErrorModel) return citites;

    var data = (res as Map<String, dynamic>);
    var results = data["results"] as List<dynamic>;
    citites = results.map((item) => LocationModel.fromMap(item)).toList();
    return citites;
  }

  Future<List<LocationModel>> fetchDistricts(String cityId) async {
    List<LocationModel> districts = [];

    String url = "/district?province=$cityId";
    var res = await _request.requestApi(method: MethodType.GET, url: url);

    if (res is ErrorModel) return districts;
    var data = (res as Map<String, dynamic>);
    var results = data["results"] as List<dynamic>;
    districts = results.map((item) => LocationModel.fromMap(item)).toList();
    return districts;
  }

  Future<List<LocationModel>> fetchWards(String districtId) async {
    List<LocationModel> wards = [];

    String url = "/commune?district=$districtId";
    var res = await _request.requestApi(method: MethodType.GET, url: url);

    if (res is ErrorModel) return wards;
    var data = (res as Map<String, dynamic>);
    var results = data["results"] as List<dynamic>;
    wards = results.map((item) => LocationModel.fromMap(item)).toList();
    return wards;
  }
}
