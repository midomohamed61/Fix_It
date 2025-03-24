import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  // private constructor as I don't want to allow creating an instance of this class itself.
  SharedPrefHelper._();

  static const _isWeb = kIsWeb; // To check if the platform is web.

  // Remove a value from SharedPreferences with given [key].
  static removeData(String key) async {
    debugPrint('SharedPrefHelper : data with key : $key has been removed');
    if (_isWeb) {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.remove(key);
    } else {
      const flutterSecureStorage = FlutterSecureStorage();
      await flutterSecureStorage.delete(key: key);
    }
  }

  // Save a [value] with a [key] in SharedPreferences (for Web) or SecureStorage (for other platforms).
  static setData(String key, value) async {
    debugPrint("SharedPrefHelper : setData with key : $key and value : $value");

    if (_isWeb) {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      switch (value.runtimeType) {
        case String:
          await sharedPreferences.setString(key, value);
          break;
        case int:
          await sharedPreferences.setInt(key, value);
          break;
        case bool:
          await sharedPreferences.setBool(key, value);
          break;
        case double:
          await sharedPreferences.setDouble(key, value);
          break;
        default:
          return null;
      }
    } else {
      const flutterSecureStorage = FlutterSecureStorage();
      await flutterSecureStorage.write(key: key, value: value.toString());
    }
  }

  // Get a String value from SharedPreferences or SecureStorage.
  static getString(String key) async {
    debugPrint('SharedPrefHelper : getString with key : $key');
    if (_isWeb) {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      return sharedPreferences.getString(key) ?? '';
    } else {
      const flutterSecureStorage = FlutterSecureStorage();
      return await flutterSecureStorage.read(key: key) ?? '';
    }
  }
}
