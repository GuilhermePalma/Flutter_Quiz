import 'package:flutter/material.dart';
import 'customText.dart';

class Result extends StatelessWidget {
  final void Function() onResetQuiz;
  final double scoreQuiz;

  Result({required this.scoreQuiz, required this.onResetQuiz});

  @override
  Widget build(BuildContext context) {
    String valueScore = scoreQuiz.toString().length > 4
        ? scoreQuiz.toString().substring(0, 4)
        : scoreQuiz.toString();

    return Column(
      // Centraliza o Conteudo
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          scoreQuiz > 6 ? "Parabens !" : "Que pena, não foi dessa vez.",
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
