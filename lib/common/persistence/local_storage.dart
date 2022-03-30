import 'package:shared_preferences/shared_preferences.dart';
import 'package:pubdates/common/persistence/key_value_store.dart';

class LocalStorage implements KeyValueStore {
  const LocalStorage({
    required SharedPreferences preferences,
  }) : _preferences = preferences;

  final SharedPreferences _preferences;

  @override
  Future<void> delete(String key) {
    return _preferences.remove(key);
  }

  @override
  Future<String?> getString(String key) {
    return Future.value(_preferences.getString(key));
  }

  @override
  Future<List<String>?> getStrings(String key) {
    return Future.value(_preferences.getStringList(key));
  }

  @override
  Future<void> putString(String key, String value) {
    return _preferences.setString(key, value);
  }

  @override
  Future<void> putStrings(String key, List<String> values) {
    return _preferences.setStringList(key, values);
  }
}
