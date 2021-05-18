import 'package:e_commerce_app/constants/key_constant.dart';

class ErrorModel {
  int code;
  String description;
  String message;

  ErrorModel({
    this.code = 0,
    this.message = KEY_CONST.error,
    this.description = KEY_CONST.unknown_error,
  });
}
