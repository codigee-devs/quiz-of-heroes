import 'package:logging/logging.dart';

import '../app/remote.dart';

abstract class AppLogger {
  ///LOGGERS
  static final _general = 'CODIGEE_LOG';
  static final _database = 'DATABASE';
  static final isDev = true;

  static Future<void> init() async {
    Logger.root.level = Level.ALL; // defaults to Level.INFO
    Logger.root.onRecord.listen((record) {
      // ignore: avoid_print
      print('${record.level.name}: ${record.time}: ${record.message}');
    });
  }

  ///LOG EVENT METHODS
  ///
  /// verbose is visible at production
  static void public(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    Logger.root.info('[$_general] $message', error, stackTrace);
  }

  /// config
  static void config(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (isDev) Logger.root.info('❕[$_general] $message ❕', error, stackTrace);
  }

  /// debug
  static void dev(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (isDev) Logger.root.info('[$_general] $message', error, stackTrace);
  }

  static void database(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (isDev) Logger.root.info('[$_database] $message', error, stackTrace);
  }

  /// what a terrible failure
  static void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (isDev) Logger.root.info('⁉️😂️ [$_general] $message', error, stackTrace);
  }

  /// error
  static void error(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (isDev) Logger.root.info('❌❌ [$_general] $message ❌❌', error, stackTrace);
    RemoteCore.logError(message, error, stackTrace);
  }

  static void errorDatabase(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (isDev) Logger.root.info('❌❌ [$_database] $message ❌❌', error, stackTrace);
  }
}
