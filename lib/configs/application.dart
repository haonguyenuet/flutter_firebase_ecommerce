import 'package:shared_preferences/shared_preferences.dart';

class Application {
  static bool debug = false;
  static String title = "E-commerce-app";
  static late SharedPreferences preferences;

  Future<void> setPreferences() async {
    preferences = await SharedPreferences.getInstance();
  }

  /// Singleton factory
  static final Application _instance = Application._internal();

  factory Application() {
    return _instance;
  }

  Application._internal();
}
