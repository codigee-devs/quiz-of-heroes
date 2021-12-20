import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import '../../../core/config/config.dart';
import '../../../core/logger/logger.dart';
import '../../dto/hero_dto.dart';

abstract class ConfigHeroesLocalDataSource {
  Future<List<HeroDto>?> getHeroesFromJson();
}

@Injectable(as: ConfigHeroesLocalDataSource)
class ConfigHeroesLocalDataSourceImpl implements ConfigHeroesLocalDataSource {
  @override
  Future<List<HeroDto>?> getHeroesFromJson() async {
    try {
      final path = await rootBundle.loadString(AppPaths.jsonHeroesConfig);
      final source = json.decode(path);
      return List<HeroDto>.from(source.map((json) => HeroDto.fromJson(json)));
    } on Exception catch (e) {
      AppLogger.error('ConfigHeroesDataSource: $e');
      return null;
    }
  }
}
