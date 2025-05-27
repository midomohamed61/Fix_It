import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static const _secureStorage = FlutterSecureStorage();
  static SharedPreferences? _prefs;

  static Future<void> _init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static Future<void> removeData(String key) async {
    try {
      if (kIsWeb) {
        await _init();
        await _prefs?.remove(key);
      } else {
        await _secureStorage.delete(key: key);
      }
    } catch (e) {
      debugPrint('Error removing $key: $e');
    }
  }

  static Future<void> setData<T>(String key, T value) async {
    try {
      if (kIsWeb) {
        await _init();
        switch (T) {
          case String:
            await _prefs?.setString(key, value as String);
            break;
          case int:
            await _prefs?.setInt(key, value as int);
            break;
          case bool:
            await _prefs?.setBool(key, value as bool);
            break;
          case double:
            await _prefs?.setDouble(key, value as double);
            break;
          default:
            throw Exception('Unsupported type $T');
        }
      } else {
        await _secureStorage.write(
          key: key,
          value: value.toString(),
        );
      }
    } catch (e) {
      debugPrint('Error saving $key: $e');
    }
  }

  static Future<String> getString(String key) async {
    try {
      if (kIsWeb) {
        await _init();
        return _prefs?.getString(key) ?? '';
      }
      return await _secureStorage.read(key: key) ?? '';
    } catch (e) {
      debugPrint('Error reading $key: $e');
      return '';
    }
  }

  static Future<int> getInt(String key) async {
    try {
      if (kIsWeb) {
        await _init();
        return _prefs?.getInt(key) ?? 0;
      }
      final value = await _secureStorage.read(key: key);
      return int.tryParse(value ?? '') ?? 0;
    } catch (e) {
      debugPrint('Error reading $key: $e');
      return 0;
    }
  }

  static Future<bool> getBool(String key) async {
    try {
      if (kIsWeb) {
        await _init();
        return _prefs?.getBool(key) ?? false;
      }
      final value = await _secureStorage.read(key: key);
      return value?.toLowerCase() == 'true';
    } catch (e) {
      debugPrint('Error reading $key: $e');
      return false;
    }
  }

  static Future<double> getDouble(String key) async {
    try {
      if (kIsWeb) {
        await _init();
        return _prefs?.getDouble(key) ?? 0.0;
      }
      final value = await _secureStorage.read(key: key);
      return double.tryParse(value ?? '') ?? 0.0;
    } catch (e) {
      debugPrint('Error reading $key: $e');
      return 0.0;
    }
  }

  static Future<void> setStringList(String key, List<String> value) async {
  try {
    final joined = value.join(',');
    await setData<String>(key, joined);
  } catch (e) {
    debugPrint('Error saving list for $key: $e');
  }
}

static Future<List<String>> getStringList(String key) async {
  try {
    final data = await getString(key);
    if (data.isEmpty) return [];
    return data.split(',').map((e) => e.trim()).toList();
  } catch (e) {
    debugPrint('Error reading list for $key: $e');
    return [];
  }
}

}