import 'package:flutter/material.dart';

import '../model/entities/quiz_entity.dart';
import 'buttonAnswer.dart';
import 'customText.dart';

class Quiz extends StatelessWidget {
  final QuizEntity quizEntity;
  final void Function(int) clickButton;

  const Quiz({Key? key, required this.quizEntity, required this.clickButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [CustomText(quizEntity.question), ..._getResponses()],
    );
  }

  List<Widget> _getResponses() => [
        ...quizEntity.incorrectAnswers
            .map((e) => ButtonAnswer(e, () => clickButton(0))),
        ButtonAnswer(quizEntity.correctAnswer, () => clickButton(10))
      ]..shuffle();
}
