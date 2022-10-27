class QuizView {
  final String _question;
  final bool _isCorrect;

  QuizView({required question, required isCorrect})
      : _question = question,
        _isCorrect = isCorrect;

  bool get isCorrect => _isCorrect;

  String get question => _question;
}
