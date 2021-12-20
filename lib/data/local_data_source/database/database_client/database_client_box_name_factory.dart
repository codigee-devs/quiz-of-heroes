abstract class DatabaseClientBoxNameFactory {
  static String build({required String type, List<String>? params}) {
    if (params != null && params.isNotEmpty) {
      return 'codigeeHiveBoxName.$type.${params.join('.')}';
    } else {
      return 'codigeeHiveBoxName.$type';
    }
  }
}
