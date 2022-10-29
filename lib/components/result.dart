import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final void Function() onResetQuiz;
  final double scoreQuiz;

  const Result({Key? key, required this.scoreQuiz, required this.onResetQuiz})
      : super(key: key);

  String get phraseResult {
    if (scoreQuiz >= 8) {
      return "Parabéns ! Você conhece muito de Flutter";
    } else if (scoreQuiz >= 7) {
      return "Parabéns ! Você sabe algumas coisas sobre o Flutter";
    } else if (scoreQuiz < 5) {
      return "Não foi dessa vez ! Você conhece pouco do Flutter";
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
          child: Text(
            phraseResult,
            style: const TextStyle(
              fontSize: 28,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          margin: const EdgeInsets.all(16),
          child: Text(
            // Mostra a Pontuação com 2 Casas Decimais
            "Sua Pontuação Media foi: $valueScore",
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
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
