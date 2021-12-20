import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import 'secure_storage.dart';

typedef Factory<T> = T Function(dynamic json);

@Injectable(as: SecureStorage)
class SecureStorageImpl implements SecureStorage {
  final FlutterSecureStorage _secureStorage;

  SecureStorageImpl(this._secureStorage);

  @override
  Future<void> write({required String key, required dynamic value}) =>
      _secureStorage.write(key: key, value: json.encode(value));

  @override
  Future<T?> read<T>({required String key, required Factory<T> factory}) =>
      _secureStorage.read(key: key).then((value) => _create(value, factory));

  T? _create<T>(String? value, Factory<T> factory) => value != null ? factory(json.decode(value)) : null;

  @override
  Future<void> delete({required String key}) => _secureStorage.delete(key: key);
}
