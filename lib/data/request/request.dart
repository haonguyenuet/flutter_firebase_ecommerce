import 'dart:async';
import 'package:dio/dio.dart';
import 'package:e_commerce_app/constants/key_constant.dart';
import 'package:e_commerce_app/data/models/error_model.dart';
import 'package:e_commerce_app/data/request/api_url.dart';
import 'package:e_commerce_app/utils/logger.dart';

Map<MethodType, String> methods = {
  MethodType.GET: "GET",
  MethodType.POST: "POST"
};

class Request {
  Dio _dio = Dio();

  Request({required String baseUrl}) {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      receiveTimeout: environment.receiveTimeout,
      connectTimeout: environment.connectTimeout,
      contentType: "application/json",
    ));
  }

  Future<Object> requestApi(
      {required MethodType method,
      required String url,
      Map<String, dynamic>? data,
      Map<String, dynamic>? header}) async {
    Logger.info("URL: " + url + "\n" + "body: " + data.toString());
    try {
      var response = await _dio.request(
        url,
        data: data,
        options: Options(method: methods[method], headers: header),
      );

      return response.data;
    } catch (e) {
      Logger.error(e.toString());
      return handleError(e);
    }
  }

  Future<ErrorModel> handleError(dynamic error) async {
    ErrorModel errorModel = ErrorModel();
    errorModel.message = error.toString();
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.sendTimeout:
          errorModel.description = KEY_CONST.request_send_timeout;
          break;
        case DioErrorType.cancel:
          errorModel.description = KEY_CONST.request_cancelled;
          break;
        case DioErrorType.connectTimeout:
          errorModel.description = KEY_CONST.request_connect_timeout;
          break;
        case DioErrorType.other:
          errorModel.description = KEY_CONST.no_internet;
          break;
        case DioErrorType.receiveTimeout:
          errorModel.description = KEY_CONST.request_receive_timeout;
          break;
        case DioErrorType.response:
          Logger.error(error.response!.toString());
          try {
            errorModel.code = error.response?.statusCode ?? errorModel.code;
            errorModel.description =
                error.response?.data ?? errorModel.description;
          } catch (e) {
            Logger.error(e.toString());
          }
          break;
      }
    }
    return errorModel;
  }
}
