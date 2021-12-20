abstract class DatabaseClient {
  Future<Iterable<T?>> getAll<T>({
    required String name,
  });

  Future<void> putAt<T>({
    required String name,
    required int index,
    required T value,
  });

  Future<void> putAtKey<T>({
    required String name,
    required String key,
    required T value,
  });

  Future<T?> getWithKey<T>({
    required String name,
    required String key,
  });

  Future<void> add<T>({
    required String name,
    required T value,
  });

  Future<void> addAll<T>({
    required String name,
    required Iterable<T> values,
  });

  Future<void> deleteAt({
    required String name,
    required int index,
  });

  Future<void> clear({
    required String name,
  });
}
