import 'package:flutter_test/flutter_test.dart';
import 'package:quiz/utils/requests_url.dart';

void main() {
  test('static void method', () {
    expect("1,2,3", RequestsUrl.formatParameters([1, 2, 3]));
  });

  test("check request mapping", () {
    Map<String, Object> map = {
      RequestsUrl.paramCategories: "film_and_tv",
      RequestsUrl.paramLimit: 5,
      RequestsUrl.paramRegion: "BR",
      RequestsUrl.paramDifficulty: "medium",
      RequestsUrl.paramTags: "academy_awards",
    };

    expect(
        "https://the-trivia-api.com/api/questions?categories=film_and_tv&limit=5&region=BR&difficulty=medium&tags=academy_awards",
        RequestsUrl.createRequest(RequestsUrl.urlQuestionsBase, map));
  });
}
