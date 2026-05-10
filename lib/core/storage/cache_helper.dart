// core/storage/cache_helper.dart
// In-memory cache - no external dependencies needed

class CacheHelper {
  static final Map<String, dynamic> _cache = {};

  static Future<void> init() async {
    // Nothing to initialize for in-memory cache
  }

  static Future<bool> setString(String key, String value) async {
    _cache[key] = value;
    return true;
  }

  static String? getString(String key) {
    return _cache[key] as String?;
  }

  static Future<bool> setBool(String key, bool value) async {
    _cache[key] = value;
    return true;
  }

  static bool? getBool(String key) {
    return _cache[key] as bool?;
  }

  static Future<bool> remove(String key) async {
    _cache.remove(key);
    return true;
  }

  static Future<bool> clear() async {
    _cache.clear();
    return true;
  }
}