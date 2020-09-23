import 'package:dio/dio.dart';
import 'package:flutter_starter_kit/app/models/api/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  SharedPreferences _sharedPref;

  static const String KEY_FIREBASE_DEVICE_ID = "firebase_device_id";

  static const String KEY_AUTH_TOKEN = "auth_token";
  static const String KEY_REFRESH_TOKEN = "refresh_token";
  static const String KEY_EXPIRED_TIME = "expired_time";
  static const String KEY_USER_UID = "user_uid";

  Future<SharedPrefHelper> init() async {
    _sharedPref = await SharedPreferences.getInstance();
    return this;
  }

  String get firebaseDeviceId => _sharedPref.getString(KEY_FIREBASE_DEVICE_ID);

  String get authToken => _sharedPref.getString(KEY_AUTH_TOKEN);

  String get refreshToken => _sharedPref.getString(KEY_REFRESH_TOKEN);

  String get expiredTime => _sharedPref.getString(KEY_EXPIRED_TIME);

  String get userUid => _sharedPref.getString(KEY_USER_UID);

  /// If value can't set for some reason,
  /// it will return false
  Future<bool> setFirebaseDeviceId(String value) async {
    return await _sharedPref.setString(KEY_FIREBASE_DEVICE_ID, value);
  }

  Future<bool> setAuthToken(String value) async {
    return await _sharedPref.setString(KEY_AUTH_TOKEN, value);
  }

  Future<bool> setRefreshToken(String value) async {
    return await _sharedPref.setString(KEY_REFRESH_TOKEN, value);
  }

  Future<bool> setExpiredTime(String value) async {
    return await _sharedPref.setString(KEY_EXPIRED_TIME, value);
  }

  Future<bool> setUserUid(String value) async {
    return await _sharedPref.setString(KEY_USER_UID, value);
  }

  /// auth stuff
  /// ----------------
  Future<bool> isLoggedIn() async {
    if (authToken == null) {
      return false;
    }

    final AuthProvider _authProvider = AuthProvider();
    final currTime = DateTime.now();
    final currExpiredTime = DateTime.parse(expiredTime);

    if (currTime.isAfter(currExpiredTime)) {
      try {
        final resRefresh = await _authProvider.refreshToken(refreshToken);

        if (resRefresh.error) {
          return false;
        }

        final data = resRefresh.data;
        final newExpiredTime = currTime.add(Duration(seconds: data.expiresIn));

        await setAuthToken(data.accessToken);
        await setRefreshToken(data.refreshToken);
        await setExpiredTime(newExpiredTime.toString());

        return true;
      } on DioError catch (err) {
        print(err);
        await logout();
        return false;
      }
    }
    return true;
  }

  Future<void> logout() async {
    await _sharedPref.remove(SharedPrefHelper.KEY_AUTH_TOKEN);
    await _sharedPref.remove(SharedPrefHelper.KEY_REFRESH_TOKEN);
    await _sharedPref.remove(SharedPrefHelper.KEY_EXPIRED_TIME);
    await _sharedPref.remove(SharedPrefHelper.KEY_USER_UID);
  }
}
