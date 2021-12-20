import 'dart:async';

import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/logger/logger.dart';
import '../../../failures/failure.dart';
import 'database_client.dart';

@LazySingleton(as: DatabaseClient)
class DatabaseClientImpl implements DatabaseClient {
  const DatabaseClientImpl();

  @override
  Future<Iterable<T?>> getAll<T>({
    required String name,
  }) {
    _logMessage(message: 'getAll', name: name);

    late Box<T> openedBox;
    late Iterable<T> openedResult;

    return _openBox<T>(name: name)
        .then((box) => openedBox = box)
        .then((_) => openedResult = openedBox.values)
        .then((value) => _logMessage(message: 'found ${openedResult.length} items', name: name))
        .then((_) => openedResult)
        .catchError((e) => Iterable<T>.empty())
        .whenComplete(() => _closeBox(box: openedBox, name: name));
  }

  @override
  Future<T?> getWithKey<T>({
    required String name,
    required String key,
  }) {
    _logMessage(message: 'getWithKey ${key.toLowerCase()}', name: name);

    late Box<T> openedBox;
    late T? openedResult;

    return _openBox<T>(name: name)
        .then((box) => openedBox = box)
        .then((_) => openedResult = openedBox.get(key.toLowerCase(), defaultValue: null))
        .then((value) => _logMessage(message: 'getWithKey $openedResult item', name: name))
        .then((_) => openedResult)
        .catchError((e) => null)
        .whenComplete(() => _closeBox(box: openedBox, name: name));
  }

  @override
  Future<void> putAt<T>({
    required String name,
    required int index,
    required T value,
  }) {
    _logMessage(message: 'putAt', name: name);

    late Box<T> openedBox;

    return _openBox<T>(name: name)
        .then((box) => openedBox = box)
        .then((_) => openedBox.values.length > index ? openedBox.putAt(index, value) : openedBox.add(value))
        .then((_) => _logMessage(message: 'successfully put: $value at index: $index', name: name))
        .catchError((e) => _catchError(error: e, name: name))
        .whenComplete(() => _closeBox(box: openedBox, name: name));
  }

  @override
  Future<void> putAtKey<T>({
    required String name,
    required String key,
    required T value,
  }) {
    _logMessage(message: 'putAtKey ${key.toLowerCase()} $value', name: name);

    late Box<T> openedBox;

    return _openBox<T>(name: name)
        .then((box) => openedBox = box)
        .then((_) => openedBox.put(key.toLowerCase(), value))
        .then((_) => _logMessage(message: 'successfully put: $value at key: $key', name: name))
        .catchError((e) => _catchError(error: e, name: name))
        .whenComplete(() => _closeBox(box: openedBox, name: name));
  }

  @override
  Future<void> add<T>({
    required String name,
    required T value,
  }) {
    _logMessage(message: 'add', name: name);

    late Box<T> openedBox;

    return _openBox<T>(name: name)
        .then((box) => openedBox = box)
        .then((_) => openedBox.add(value))
        .then((_) => _logMessage(message: 'successfully add: $value', name: name))
        .then((_) => _logMessage(message: 'successfully _trackOperation: $name', name: name))
        .catchError((e) => _catchError(error: e, name: name))
        .whenComplete(() => _closeBox(box: openedBox, name: name));
  }

  @override
  Future<void> addAll<T>({
    required String name,
    required Iterable<T> values,
  }) {
    _logMessage(message: '[DatabaseClientImpl] addAll', name: name);

    late Box<T> openedBox;

    return _openBox<T>(name: name)
        .then((box) => openedBox = box)
        .then((_) => openedBox.addAll(values))
        // ignore: invalid_return_type_for_catch_error
        .catchError((e) => _catchError(error: e, name: name))
        .whenComplete(() => _closeBox(box: openedBox, name: name));
  }

  @override
  Future<void> deleteAt({
    required String name,
    required int index,
  }) {
    _logMessage(message: 'deleteAt', name: name);

    late Box openedBox;

    return _openBox(name: name)
        .then((box) => openedBox = box)
        .then((_) => openedBox.deleteAt(index))
        .catchError((e) => _catchError(error: e, name: name))
        .whenComplete(() => _closeBox(box: openedBox, name: name));
  }

  @override
  Future<void> clear({
    required String name,
  }) {
    _logMessage(message: '[DatabaseClientImpl] clear', name: name);

    late Box openedBox;

    return _openBox(name: name)
        .then((box) => openedBox = box)
        .then((_) => openedBox.clear())
        .then((_) => _logMessage(message: 'successfully clear: $openedBox', name: name))
        .catchError((e) => _catchError(error: e, name: name))
        .whenComplete(() => _closeBox(box: openedBox, name: name));
  }

  // DEBUG METHODS
  Future<Box<T>> _openBox<T>({required String name}) async {
    AppLogger.database('"$name" (_openBox)');
    return Hive.openBox<T>(name);
  }

  Future<void> _closeBox({required Box box, required String name}) async {
    AppLogger.database('"$name" (_closeBox)');
    return box.close().catchError((e) => _catchError(error: e, name: name));
  }

  Future<void> _catchError({required dynamic error, required String name}) {
    AppLogger.errorDatabase('["$name" (_catchError: $error)');
    return Future.error(Failure.databaseClientFailure());
  }

  void _logMessage<T>({required String message, required String name}) {
    AppLogger.database('"$name": ($message)');
  }
}