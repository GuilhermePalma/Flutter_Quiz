import 'package:flutter/material.dart';

import '../model/entities/quiz_entity.dart';
import 'buttonAnswer.dart';
import 'customText.dart';

class Quiz extends StatefulWidget {
  final QuizEntity quizEntity;
  final void Function(int) clickButton;

  const Quiz({Key? key, required this.quizEntity, required this.clickButton})
      : super(key: key);

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  bool isAnswered = false;

  void changeIsAnswered() => setState(() => isAnswered = !isAnswered);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(widget.quizEntity.question),
        ..._getResponsesButtons(),
      ],
    );
  }

  List<Widget> _getResponsesButtons() => [
        ...widget.quizEntity.incorrectAnswers.map((e) => ButtonAnswer(
              text: e,
              isCorrectAnswer: false,
              isAnswered: isAnswered,
              functionPressed: _internalState,
            )),
        ButtonAnswer(
          text: widget.quizEntity.correctAnswer,
          isCorrectAnswer: true,
          isAnswered: isAnswered,
          functionPressed: _internalState,
        )
      ]..shuffle();

  _internalState() {
    changeIsAnswered();
    // widget.clickButton(0);
  }
}
