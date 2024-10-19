import 'package:shared_preferences/shared_preferences.dart';
import 'package:woye_user/core/app_export.dart';

class PrefUtils {
  static SharedPreferences? _sharedPreferences;

  PrefUtils() {
    // You can initialize SharedPreferences in the constructor if needed
    // init();
  }

  Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  void clearPreferencesData() async {
    await init();
    _sharedPreferences!.clear();
  }

  Future<void> saveUserDetails(Map<String, dynamic> userDetails) async {
    await init();
    _sharedPreferences!
        .setString('userDetails', jsonEncode(userDetails).toString());
  }

  Map<String, dynamic>? getUserDetails() {
    try {
      if (_sharedPreferences == null) {
        debugPrint('SharedPreferences is not initialized.');
        return null;
      }

      final userDetailsString = _sharedPreferences!.getString('userDetails');
      if (userDetailsString != null) {
        return jsonDecode(userDetailsString);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error getting user details: $e');
      return null;
    }
  }

  Future<void> saveToken(String token) async {
    await init();
    _sharedPreferences!.setString('token', token);
  }

  Future<void> saveName(String token) async {
    await init();
    _sharedPreferences!.setString('name', token);
  }

  Future<void> savePhoto(String token) async {
    await init();
    _sharedPreferences!.setString('photo', token);
  }

  Future<void> saveEmail(String token) async {
    await init();
    _sharedPreferences!.setString('email', token);
  }

  Future<void> saveUserEmail(String token) async {
    await init();
    _sharedPreferences!.setString('userEmail', token);
  }

  Future<void> saveCountryCode(String token) async {
    await init();
    _sharedPreferences!.setString('saveCountryCode', token);
  }

  Future<void> saveNumber(String token) async {
    await init();
    _sharedPreferences!.setString('saveNumber', token);
  }

  Future<void> saveRegistrationStatus(bool isRegister) async {
    await init();
    _sharedPreferences!.setBool("isRegister", isRegister);
  }

  Future<String?> getEmail() async {
    await init();
    try {
      if (_sharedPreferences == null) {
        debugPrint('SharedPreferences is not initialized.');
        return null;
      }

      return _sharedPreferences!.getString('email');
    } catch (e) {
      debugPrint('Error getting token: $e');
      return null;
    }
  }

  String? getPhotoUrl() {
    try {
      if (_sharedPreferences == null) {
        debugPrint('SharedPreferences is not initialized.');
        return null;
      }

      return _sharedPreferences!.getString('photo');
    } catch (e) {
      debugPrint('Error getting token: $e');
      return null;
    }
  }

  String? getName() {
    try {
      if (_sharedPreferences == null) {
        debugPrint('SharedPreferences is not initialized.');
        return null;
      }
      return _sharedPreferences!.getString('name');
    } catch (e) {
      debugPrint('Error getting token: $e');
      return null;
    }
  }

  Future<String?> getToken() async {
    await init();
    return _sharedPreferences!.getString('token');
  }

  Future<bool?>? getRegistrationDetails() async {
    await init();
    return _sharedPreferences!.getBool("isRegister");
  }

  Future<void> logout() async {
    await init(); // Ensure SharedPreferences is initialized before using it
    _sharedPreferences!.remove('userDetails');
    _sharedPreferences!.remove('token');
    _sharedPreferences!.remove('name');
    _sharedPreferences!.remove('username');
    _sharedPreferences!.remove('userID');
    _sharedPreferences!.remove('photo');
    _sharedPreferences!.remove('sub');

    _sharedPreferences!.clear();
  }
}
