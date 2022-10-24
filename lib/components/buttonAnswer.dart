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
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: isAnswered
          ? ElevatedButton.icon(
              label: Text(text),
              icon: Icon(
                isCorrectAnswer ? Icons.check_outlined : Icons.block,
              ),
              onPressed: functionPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: isCorrectAnswer ? Colors.green : Colors.red,
                alignment: Alignment.centerLeft,
              ),
            )
          : ElevatedButton(
              onPressed: functionPressed,
              child: Text(text),
            ),
    );
  }
}
