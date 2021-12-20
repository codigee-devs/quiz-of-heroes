typedef Factory<T> = T Function(dynamic json);

abstract class SecureStorage {
  static const String storageKeyAuthorization = 'authorization';

  Future<void> write({required String key, required dynamic value});

  Future<T?> read<T>({required String key, required Factory<T> factory});

  Future<void> delete({required String key});
}
