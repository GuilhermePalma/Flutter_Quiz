import 'package:flutter/material.dart';
import 'package:quiz/model/view/quiz_view.dart';

import '../components/quiz.dart';
import '../components/result.dart';
import '../model/entities/quiz_entity.dart';

// Cria o Estado dos Widgets do APP. Esses Widgets podem ser alterados em tempo de execução
class QuizScreen extends StatefulWidget {
  final List<QuizEntity> quiz;

  const QuizScreen({Key? key, required this.quiz}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<QuizScreen> {
  // Declaração de Variaveis Utilizadas
  int indexQuestion = 0;
  int finalScore = 0;

  // Metodo que Verifica se Todas as Questões já foram exibidas
  bool get hasNextQuestion => indexQuestion < widget.quiz.length;

  // Metodo Acionado ao Responder uma Questão
  void whenAnswer(dynamic isCorrect) {
    if (hasNextQuestion && isCorrect is bool) {
      setState(() => indexQuestion++);
      finalScore += isCorrect ? 10 : 0;
    }
  }

  // Metodo para Reiniciar o Quiz
  void onResetQuiz() => setState(() {
        indexQuestion = 0;
        finalScore = 0;
      });

  double get _scoreQuiz => finalScore / widget.quiz.length;

  // Criação do Widget da Pagina Principal
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quiz APP")),
      body: hasNextQuestion
          ? Quiz(
              quizEntity: widget.quiz[indexQuestion],
              clickButton: whenAnswer,
              questions: _generateQuestions,
            )
          : Result(
              scoreQuiz: _scoreQuiz,
              onResetQuiz: onResetQuiz,
            ),
    );
  }

  List<QuizView> get _generateQuestions =>
      widget.quiz[indexQuestion].incorrectAnswers
          .map((e) => QuizView(question: e, isCorrect: false))
          .toList()
        ..add(QuizView(
            question: widget.quiz[indexQuestion].correctAnswer,
            isCorrect: true))
        ..shuffle();
}
