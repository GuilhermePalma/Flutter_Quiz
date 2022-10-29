import 'package:flutter/material.dart';
import 'package:quiz/components/custom_text.dart';

class Result extends StatelessWidget {
  final void Function() onResetQuiz;
  final double scoreQuiz;

  const Result({Key? key, required this.scoreQuiz, required this.onResetQuiz})
      : super(key: key);

  String get phraseResult {
    if (scoreQuiz >= 8) {
      return "Parabéns ! Você foi Incrivel !";
    } else if (scoreQuiz >= 7) {
      return "Parabéns ! Você foi Otimo !";
    } else if (scoreQuiz < 5) {
      return "Não foi dessa vez ! Você não foi muito bem.";
    } else {
      return "Ops, ocorreu um Erro.";
    }
  }

  @override
  Widget build(BuildContext context) {
    String valueScore = scoreQuiz.toString().length > 4
        ? scoreQuiz.toString().substring(0, 4)
        : scoreQuiz.toString();

    return Column(
      // Centraliza o Conteudo
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 8, 8),
          child: CustomText(
            phraseResult,
            textStyle: const TextStyle(fontSize: 28),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          margin: const EdgeInsets.all(16),
          child: CustomText(
            "Your average score was: $valueScore",
            textStyle: const TextStyle(fontSize: 16, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
        ElevatedButton(
          onPressed: onResetQuiz,
          child: const Text("Responder Novamente"),
        ),
      ],
    );
  }
}
