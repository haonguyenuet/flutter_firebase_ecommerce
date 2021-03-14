import 'package:shared_preferences/shared_preferences.dart';

abstract class Pref {
  Future<bool> saveString(String key, String value);

  Future<String> getString(String key);

  Future<bool> removeString(String key);
}

class LocalPref extends Pref {
  @override
  Future<bool> saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  @override
  Future<String> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key)!;
  }

  @override
  Future<bool> removeString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}
