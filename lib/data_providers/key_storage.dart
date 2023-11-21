abstract class KeyStorage {
  Future<String?> readkey();

  Future<void> savekey(String key);
}

class InMemoryKeyStorage implements KeyStorage {
  String? _key;

  @override
  Future<String?> readkey() async => _key;

  @override
  Future<void> savekey(String key) async => _key = key;
}
