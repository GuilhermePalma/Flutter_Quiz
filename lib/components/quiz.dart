import 'package:flutter/material.dart';

import '../model/entities/quiz_entity.dart';
import '../model/view/quiz_view.dart';
import 'button_answer.dart';
import 'custom_text.dart';

class Quiz extends StatefulWidget {
  final QuizEntity quizEntity;
  final void Function(dynamic) clickButton;
  final List<QuizView> questions;

  const Quiz({
    Key? key,
    required this.quizEntity,
    required this.clickButton,
    required this.questions,
  }) : super(key: key);

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  bool isAnswered = false;
  List<ButtonAnswer>? values;

  void changeIsAnswered() => setState(() => isAnswered = !isAnswered);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomText(widget.quizEntity.question),
        ..._getResponsesButtons(),
      ],
    );
  }

  List<ButtonAnswer> _getResponsesButtons() => widget.questions
      .map((e) => ButtonAnswer(
            text: e.question,
            isCorrectAnswer: e.isCorrect,
            isAnswered: isAnswered,
            functionPressed: () async {
              changeIsAnswered();
              await Future.delayed(const Duration(seconds: 3), () {});
              changeIsAnswered();
              widget.clickButton(e.isCorrect);
            },
          ))
      .toList();
}
