import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  SharedPref();

  SharedPreferences? _prefs;

  Future<SharedPreferences?> initialize() async {
    if (_prefs != null) {
      return _prefs;
    } else {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  Future<bool> saveToken(String token) async {
    if (_prefs == null) {
      await initialize(); // initialize() çağrısını ekleyin
    }
    print(token);
    return await _prefs!.setString('token', token);
  }

  Future<bool> enteredBefore(bool isEnter) async {
    if (_prefs == null) {
      await initialize(); // initialize() çağrısını ekleyin
    }
    return await _prefs!.setBool('enteredBefore', isEnter );
  }
  Future<bool?> getenteredBefore() async {
    if (_prefs == null) {
      await initialize(); // initialize() çağrısını ekleyin
    }
    return await _prefs!.getBool('enteredBefore');
  }
  Future<String?> getToken() async {
    if (_prefs == null) {
      await initialize(); // initialize() çağrısını ekleyin
    }
    return _prefs!.getString('token');
  }

  Future<Future<bool>> sharedClear() async {
    if (_prefs == null) {
      await initialize(); // initialize() çağrısını ekleyin
    }
    return _prefs!.clear();
  }
}
