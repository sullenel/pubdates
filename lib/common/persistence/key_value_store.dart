// Going full enterprise once again.
// FIXME: maybe rename getX methods to xOf (e.g., doubleOf, stringOf, etc.)?
abstract class KeyValueStore {
  Future<void> putString(String key, String value);

  Future<String?> getString(String key);

  Future<void> putStrings(String key, List<String> values);

  Future<List<String>?> getStrings(String key);

  Future<void> delete(String key);

  Future<void> putDouble(String key, double value);

  Future<double?> getDouble(String key);
}
