import 'package:flutter_test/flutter_test.dart';
import 'package:project_skeleton/core/logger/logger.dart';
import 'package:project_skeleton/data/dto/question_dto.dart';
import 'package:project_skeleton/data/local_data_source/questions_local_data_source/questions_local_data_source.dart';
import 'package:project_skeleton/data/repositories/questions_repository/questions_repository.dart';

void main() {
  late QuestionsLocalDataSource dataSource;
  late QuestionsRepository repository;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    AppLogger.init();
    dataSource = QuestionsLocalDataSourceImpl();
    repository = QuestionsRepositoryImpl(dataSource);
  });

  group('[Questions Repository]', () {
    test('result isRight, and return array of QuestionDto', () async {
      // act
      final result = await repository.getQuestions();
      final question = result.fold((l) => l, (r) => r.first);
      // assert
      expect(result.isRight(), true);
      expect(question, isA<QuestionDto>());
    });

    test('every question include four answers and description', () async {
      // arrange
      const answersCount = 4;
      const locale = 'pl';
      // act
      final result = await repository.getQuestions();
      final questions = result.fold((l) => l, (r) => r) as List<QuestionDto>;
      // assert
      for (var question in questions) {
        expect(question.description[locale]!.isNotEmpty, true);
        expect(question.answers.length == answersCount, true);
        for (var answer in question.answers) {
          expect(answer.description[locale]!.isNotEmpty, true);
        }
      }
    });

    test('every question have unique id and description', () async {
      // arrange
      var ids = <int>[];
      var descriptions = <String>[];
      var isEveryQuestionUnique = true;
      const locale = 'pl';
      // act
      final result = await repository.getQuestions();
      final questions = result.fold((l) => l, (r) => r) as List<QuestionDto>;
      for (var question in questions) {
        if (!(ids.contains(question.id)) && !(descriptions.contains(question.description[locale]))) {
          ids.add(question.id);
          descriptions.add(question.description[locale]!);
        } else {
          AppLogger.dev('Question with id: ${question.id}, is not unique!');
          isEveryQuestionUnique = false;
        }
      }
      // assert
      expect(isEveryQuestionUnique, true);
    });

    test('first and last id, and questions count agrees with json', () async {
      // arrange
      const firstId = 0;
      const lastId = 993;
      const questionsCount = lastId + 1;
      // act
      final result = await repository.getQuestions();
      final questions = result.fold((l) => l, (r) => r) as List<QuestionDto>;
      // assert
      expect(questions.first.id == firstId, true);
      expect(questions.last.id == lastId, true);
      expect(questions.length == questionsCount, true);
    });
  });
}
