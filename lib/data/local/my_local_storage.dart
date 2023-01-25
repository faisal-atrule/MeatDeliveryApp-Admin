import 'package:shared_preferences/shared_preferences.dart';

class MyLocalStorage {
  static const String isAdminLogin = "IS_ADMIN_LOGIN";

  static late final SharedPreferences prefs;

  static Future<SharedPreferences> init() async {
    return prefs = await SharedPreferences.getInstance();
  }

  //region Singleton implementation
  MyLocalStorage._internal();
  static final MyLocalStorage _myLocalStorage = MyLocalStorage._internal();
  factory MyLocalStorage() => _myLocalStorage;
  static MyLocalStorage get instance => _myLocalStorage;
  //endregion

  Future setBool(String key, bool c) async {
    await prefs.setBool(key, c);
  }

  Future<bool> getBool(String key) async {
    bool boolValue = false;
    if (prefs.containsKey(key)) {
      boolValue = prefs.getBool(key) ?? false;
    }
    return boolValue;
  }

  Future<bool> setString(String key, String value) async => await prefs.setString(key, value);

  String getString(String key) {
    String value = "";
    try{
      if(prefs.containsKey(key)){
        value = prefs.getString(key) ?? "";
      }
      else{
        value = "";
      }
    }catch(exception){
      value = "";
    }

    return value;
  }

  Future<bool> remove(String key) async => await prefs.remove(key);

  Future<bool> clear() async => await prefs.clear();
}