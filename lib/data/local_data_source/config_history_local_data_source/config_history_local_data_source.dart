import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import '../../../core/config/config.dart';
import '../../../core/logger/logger.dart';
import '../../dto/history_dto.dart';

abstract class ConfigHistoryLocalDataSource {
  Future<List<HistoryDto>?> getHistoryFromJson();
}

@Injectable(as: ConfigHistoryLocalDataSource)
class ConfigHistoryLocalDataSourceImpl implements ConfigHistoryLocalDataSource {
  Future<List<HistoryDto>?> getHistoryFromJson() async {
    try {
      final path = await rootBundle.loadString(AppPaths.jsonHistoryConfig);
      final source = json.decode(path);

      return List<HistoryDto>.from(source.map((json) => HistoryDto.fromJson(json)));
    } on Exception catch (e) {
      AppLogger.dev('ConfigHistoryDataSource: $e');
      return null;
    }
  }
}
