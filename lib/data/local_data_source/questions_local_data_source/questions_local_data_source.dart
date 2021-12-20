import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import '../../../core/config/config.dart';
import '../../../core/logger/logger.dart';
import '../../dto/question_dto.dart';

abstract class QuestionsLocalDataSource {
  Future<List<QuestionDto>?> getQuestionsFromJson();
}

@Injectable(as: QuestionsLocalDataSource)
class QuestionsLocalDataSourceImpl implements QuestionsLocalDataSource {
  @override
  Future<List<QuestionDto>?> getQuestionsFromJson() async {
    try {
      final path = await rootBundle.loadString(AppPaths.jsonQuestions);
      final source = json.decode(path);
      return List<QuestionDto>.from(source.map((json) => QuestionDto.fromJson(json)));
    } on Exception catch (e) {
      AppLogger.dev('ConfigArtefactsDataSource: $e');
      return null;
    }
  }
}
