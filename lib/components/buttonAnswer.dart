import 'package:flutter/material.dart';

class ButtonAnswer extends StatelessWidget {
  final String text;
  final bool isCorrectAnswer;
  final bool isAnswered;
  final void Function() functionPressed;

  const ButtonAnswer({
    Key? key,
    required this.text,
    required this.isCorrectAnswer,
    required this.functionPressed,
    required this.isAnswered,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: ElevatedButton(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(text),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: isAnswered
                  ? (Icon(isCorrectAnswer ? Icons.check_outlined : Icons.block))
                  : Container(),
            ),
          ],
        ),
        onPressed: functionPressed,
        style: isAnswered
            ? ElevatedButton.styleFrom(
                backgroundColor: isCorrectAnswer ? Colors.green : Colors.red,
              )
            : null,
      ),
    );
  }
}
