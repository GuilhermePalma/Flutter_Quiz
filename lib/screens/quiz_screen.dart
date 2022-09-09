import 'package:flutter/material.dart';

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
  bool get hasNextQuestion {
    return indexQuestion < widget.quiz.length;
  }

  // Metodo Acionado ao Responder uma Questão
  void onAnwser(int score) {
    if (hasNextQuestion) {
      setState(() => indexQuestion++);
      finalScore += score;
    }
  }

  // Metodo para Reiniciar o Quiz
  void onResetQuiz() => setState(() {
        indexQuestion = 0;
        finalScore = 0;
      });

  // TODO: REMOVE AND REFACT STRUCT OF QUESTIONS
  List<Map<String, Object>> _convertToMap() => widget.quiz
      .map((e) => Map<String, Object>.from({
            "question": e.question,
            "response": [
              ...e.incorrectAnswers
                  .map((e) => Map<String, Object>.from({
                        "text": e,
                        "value": 0,
                      }))
                  .toList(),
              Map<String, Object>.from({
                "text": e.correctAnswer,
                "value": 10,
              })
            ]
          }))
      .toList();

  // Criação do Widget da Pagina Principal
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quiz APP")),
      body: hasNextQuestion
          ? Quiz(
              // listQuestions: widget.quiz,
              listQuestions: _convertToMap(),
              indexSelected: indexQuestion,
              clickButton: onAnwser)
          : Result(
              scoreQuiz: finalScore / widget.quiz.length,
              onResetQuiz: onResetQuiz,
            ),
    );
  }
}
