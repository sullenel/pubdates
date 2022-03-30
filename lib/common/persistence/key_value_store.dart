// Going full enterprise once again.
abstract class KeyValueStore {
  Future<void> putString(String key, String value);

  Future<String?> getString(String key);

  Future<void> putStrings(String key, List<String> values);

  Future<List<String>?> getStrings(String key);

  Future<void> delete(String key);
}
