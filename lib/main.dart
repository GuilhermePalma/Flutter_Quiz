import 'package:flutter/material.dart';
import 'package:quiz/quiz.dart';
import 'package:quiz/result.dart';

// Metodo Inicializador do Dart
void main() => runApp(const MyApp());

// Cria o Estado dos Widgets do APP. Esses Widgets podem ser alterados em tempo de execução
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Declaração de Variaveis Utilizadas
  int indexQuestion = 0;
  int finalScore = 0;

  var listQuestions = [
    {
      "question": "Qual sua cor Favorita ?",
      "response": [
        {"text": "Azul", "value": 3},
        {"text": "Vermelho", "value": 10},
        {"text": "Laranja", "value": 4},
        {"text": "Amarelo", "value": 1},
      ],
    },
    {
      "question": "Qual sua Linguagem de Programação Preferida ?",
      "response": [
        {"text": "C#", "value": 7},
        {"text": "Flutter", "value": 10},
        {"text": "JavaScript", "value": 6},
        {"text": "Phyton", "value": 8},
      ],
    },
    {
      "question": "Qual seu Hobby ?",
      "response": [
        {"text": "Tocar um Instrumento", "value": 10},
        {"text": "Ver Series/Filmes", "value": 3},
        {"text": "Cozinhar", "value": 8},
        {"text": "Praticar Esportes", "value": 7},
      ],
    },
  ];

  // Metodo que Verifica se Todas as Questões já foram exibidas
  bool get hasNextQuestion {
    return indexQuestion < listQuestions.length;
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
        ),
        body: hasNextQuestion
            ? Quiz(
                listQuestions: listQuestions,
                indexSelected: indexQuestion,
                clickButton: onAnwser)
            : Result(
                scoreQuiz: finalScore / listQuestions.length,
                onResetQuiz: onResetQuiz,
              ),
      ),
    );
  }
}
