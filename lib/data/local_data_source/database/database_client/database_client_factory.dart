import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import '../../dbo/user_artefact_dbo.dart';
import '../../dbo/user_instance_dbo.dart';
import 'database_client.dart';
import 'database_client_impl.dart';

abstract class DatabaseClientFactory {
  static Future<DatabaseClient> create() async => path_provider
      .getApplicationDocumentsDirectory()
      .then((directory) => Hive.init(directory.path))
      .then((_) => _registerAdapters())
      .then((_) => DatabaseClientImpl());

  /// Hive supports all primitive types, List, Map, DateTime and Uint8List.
  /// If you want to store other objects, you have to register a TypeAdapter
  ///  which converts the object from and to binary form.
  ///
  /// https://docs.hivedb.dev/#/custom-objects/type_adapters
  static void _registerAdapters() {
    Hive.registerAdapter(UserArtefactDboAdapter());
    Hive.registerAdapter(UserInstanceDboAdapter());
  }
}
