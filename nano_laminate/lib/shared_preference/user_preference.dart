import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  
  static late SharedPreferences _prefs;

  static bool _isAdmin = false;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool get isAdmin {
    return _prefs.getBool('isAdmin') ?? _isAdmin;
  }

  static set isAdmin(bool isAdmin) {
    _isAdmin = isAdmin;
    _prefs.setBool('isAdmin', isAdmin);
  }

}