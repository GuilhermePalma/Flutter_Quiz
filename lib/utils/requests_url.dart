class RequestsUrl {
  static const String _urlBase = "https://the-trivia-api.com/api";
  static const String urlQuestionsBase = _urlBase + "/questions";
  static const String urlTags = _urlBase + "/tags";
  static const String urlCategories = _urlBase + "/categories";
  static const String urlMetadata = _urlBase + "/metadata";

  static const String paramCategories = "categories";
  static const String paramTags = "tags";
  static const String paramLimit = "limit";
  static const String paramRegion = "region";
  static const String paramDifficulty = "difficulty";

  static String createRequest(
      String request, Map<String, Object> valuesRequest) {
    valuesRequest.forEach((key, value) {
      request += (request.contains("?") ? "&" : "?") +
          key +
          "=" +
          ((value is List) ? formatParameters(value) : value.toString());
    });

    return request;
  }

  static String addCategoriesFilter(String request, List<Object> param) =>
      request +
      (request.contains("?") ? "&" : "?") +
      paramCategories +
      "=" +
      formatParameters(param);

  static String addTagsFilter(String request, List<Object> param) =>
      request +
      (request.contains("?") ? "&" : "?") +
      paramTags +
      "=" +
      formatParameters(param);

  static String addLimitFilter(String request, int limitItems) {
    return request +
        (request.contains("?") ? "&" : "?") +
        paramLimit +
        "=" +
        limitItems.toString();
  }

  static String addRegionEncodeFilter(String request, String encode) =>
      request + (request.contains("?") ? "&" : "?") + paramRegion + encode;

  static String addDifficultyFilter(String request, String difficulty) =>
      request +
      (request.contains("?") ? "&" : "?") +
      paramDifficulty +
      "=" +
      difficulty;

  static String formatParameters(List<dynamic> param) => param.join(",");
}
