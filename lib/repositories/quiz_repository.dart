import 'package:dio/dio.dart';
import '../models/quiz_model.dart';

class QuizRepository {
  final Dio _dio = Dio();

  Future<List<QuizModel>> getQuestions({
    required int amount,
    int? category,
    String? difficulty,
  }) async {
    final params = <String, dynamic>{
      'amount': amount,
      'type': 'multiple',
    };
    if (category != null) params['category'] = category;
    if (difficulty != null) params['difficulty'] = difficulty;

    final response = await _dio.get(
      'https://opentdb.com/api.php',
      queryParameters: params,
    );

    final results = response.data['results'] as List;
    return results.map((e) => QuizModel.fromJson(e)).toList();
  }
}