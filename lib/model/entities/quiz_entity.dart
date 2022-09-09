import 'dart:convert';

import 'package:quiz/utils/requests_url.dart';

class QuizEntity {
  final String _category;
  final String _id;
  final String _correctAnswer;
  final List<String> _incorrectAnswers;
  final String _question;
  final List<String> _tags;
  final String _type;
  final String _difficulty;
  final List<String> _regions;

  QuizEntity(
      {required String category,
      required String id,
      required List<String> incorrectAnswers,
      required String question,
      required List<String> tags,
      required String type,
      required String difficulty,
      required String correctAnswer,
      required List<String> regions})
      : _category = category,
        _id = id,
        _incorrectAnswers = incorrectAnswers,
        _correctAnswer = correctAnswer,
        _question = question,
        _tags = tags,
        _type = type,
        _difficulty = difficulty,
        _regions = regions;

  Map<String, dynamic> toMap() => {
        "id": _id,
        "category": _category,
        "incorrectAnswers": _incorrectAnswers,
        "correctAnswer": _correctAnswer,
        "question": _question,
        "tags": _tags,
        "type": _type,
        "difficulty": _difficulty,
        "regions": _regions
      };

  factory QuizEntity.fromMap(Map<String, dynamic> map) => QuizEntity(
      id: map["id"] ?? '',
      category: map["category"] ?? '',
      correctAnswer: map["correctAnswer"] ?? '',
      incorrectAnswers: List<String>.from(map["incorrectAnswers"] ?? []),
      question: map["question"] ?? '',
      tags: List<String>.from(map["tags"] ?? []),
      type: map["type"] ?? '',
      difficulty: map["difficulty"] ?? '',
      regions: List<String>.from(map["regions"] ?? []));

  String toJson() => json.encode(toMap());

  factory QuizEntity.fromJson(String source) =>
      QuizEntity.fromMap(json.decode(source));

  static List<QuizEntity> fromJsonArray(var source) {
    List<dynamic> body = jsonDecode(source);
    return body.map((e) => QuizEntity.fromMap(e)).toList();
  }

  static Map<String, Object> createRequestWithParam(
      Set<String> categories, String difficulty, Set<String> tags, int limit) {
    return {
      RequestsUrl.paramTags: List.of(tags),
      RequestsUrl.paramCategories: List.of(categories),
      RequestsUrl.paramLimit: limit,
      RequestsUrl.paramDifficulty: difficulty
    };
  }

  List<String> get regions => _regions;

  String get difficulty => _difficulty;

  String get type => _type;

  List<String> get tags => _tags;

  String get question => _question;

  List<String> get incorrectAnswers => _incorrectAnswers;

  String get id => _id;

  String get category => _category;

  String get correctAnswer => _correctAnswer;
}
