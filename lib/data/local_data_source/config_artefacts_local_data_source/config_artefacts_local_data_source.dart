import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import '../../../core/config/config.dart';
import '../../../core/logger/logger.dart';
import '../../dto/artefact_dto.dart';

abstract class ConfigArtefactsLocalDataSource {
  Future<List<ArtefactDto>?> getArtefactsFromJson();
}

@Injectable(as: ConfigArtefactsLocalDataSource)
class ConfigArtefactsLocalDataSourceImpl implements ConfigArtefactsLocalDataSource {
  Future<List<ArtefactDto>?> getArtefactsFromJson() async {
    try {
      final path = await rootBundle.loadString(AppPaths.jsonArtefactsConfig);
      final source = json.decode(path);
      return List<ArtefactDto>.from(source.map((json) => ArtefactDto.fromJson(json)));
    } on Exception catch (e) {
      AppLogger.error('ConfigArtefactsDataSource: $e');
      return null;
    }
  }
}
