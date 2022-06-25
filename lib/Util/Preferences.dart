import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  late SharedPreferences prefs;

  init() async {
    prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  Future isLoggedIn() {
    String token = '';
    return get('token').then((value) => value != null);
  }

  add(key, value) {
    isInt(value)
        ? init().then((sp) => sp.setInt(key, value))
        : init().then((sp) => sp.setString(key, value));
  }

  Future<dynamic> get(key) async {
    return init().then((sp) {
      if (!isInt(prefs.getString(key))) {
        return prefs.getString(key);
      } else {
        return prefs.getInt(key);
      }
    });
  }

  Future<Map<dynamic, dynamic>> getUserInfo() async {
    Map mp = {};
    mp['user'] = init().then((sp) {
      mp['username'] = sp.getString('username');
      mp['token'] = sp.getString('token');
    });
    return mp;
  }

  bool isInt(value) => value is int;

  Future<dynamic> logout() async {
    return init().then((prefs) {
      return prefs.clear();
    });
  }
}
