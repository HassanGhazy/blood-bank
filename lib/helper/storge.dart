import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  Future<bool> getData(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  Future<bool> setData(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }
}

final Storage shared = Storage();
