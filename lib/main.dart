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
      "question": 'Flutter somente executa em aparelhos Android.',
      "response": [
        {"text": "Falso", "value": 10},
        {"text": "Verdadeiro", "value": 0},
      ],
    },
    {
      "question": "O Flutter é um Framework escrito em cima da Linguagem Dart.",
      "response": [
        {"text": "Verdadeiro", "value": 10},
        {"text": "Falso", "value": 0},
      ],
    },
    {
      "question": 'Ao Programar em Flutter, é possivel acessar componentes '
          'utilizando as Linguagens:',
      "response": [
        {"text": "Java, Kotin e Swift", "value": 10},
        {"text": "Java, Kotin", "value": 7},
        {"text": "Java, C#", "value": 0},
        {"text": "Kotin, Angular e Swift", "value": 0},
      ],
    },
    {
      "question":
          'O Flutter renderiza os Widgets de diferentes formas, alterando '
              'o Layout caso o Sistema Operacional Seja outro',
      "response": [
        {"text": "Verdadeiro", "value": 0},
        {"text": "Falso", "value": 10},
      ],
    },
    {
      "question": 'São Elementos do Flutter:',
      "response": [
        {"text": "Text, Container, Row, Column, Stack", "value": 10},
        {"text": "Container, Row, Column", "value": 6},
        {"text": "Linear Layout", "value": 0},
        {"text": "Constraint Layout", "value": 0},
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
