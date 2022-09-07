import 'package:flutter/material.dart';

import '../components/quiz.dart';
import '../components/result.dart';
import '../data/dummy_data.dart';

// Cria o Estado dos Widgets do APP. Esses Widgets podem ser alterados em tempo de execução
class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<QuizScreen> {
  // Declaração de Variaveis Utilizadas
  int indexQuestion = 0;
  int finalScore = 0;

  // Metodo que Verifica se Todas as Questões já foram exibidas
  bool get hasNextQuestion {
    return indexQuestion < questionsList.length;
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

  // Criação do Widget da Pagina Principal
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Quiz APP"),
          actions: [
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.home_outlined),
            ),
          ],
        ),
        body: hasNextQuestion
            ? Quiz(
                listQuestions: questionsList,
                indexSelected: indexQuestion,
                clickButton: onAnwser)
            : Result(
                scoreQuiz: finalScore / questionsList.length,
                onResetQuiz: onResetQuiz,
              ),
      ),
    );
  }
}
