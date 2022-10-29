import 'dart:async';

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
  bool isLoading = false;
  List<ButtonAnswer>? values;

  void changeIsAnswered() => setState(() => isAnswered = !isAnswered);
  void changeIsLoading({bool newValueIsLoading = false}) =>
      setState(() => isLoading = newValueIsLoading);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(widget.quizEntity.question),
        const SizedBox(height: 16),
        Column(children: _getResponsesButtons()),
      ],
    );
  }

  List<Widget> _getResponsesButtons() => widget.questions
      .map((e) => Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: ButtonAnswer(
              text: e.question,
              isCorrectAnswer: e.isCorrect,
              isAnswered: isAnswered,
              isLoading: isLoading,
              functionPressed: () {
                changeIsAnswered();
                changeIsLoading(newValueIsLoading: true);
                progressIndicator(() => widget.clickButton(e.isCorrect));
              },
            ),
          ))
      .toList();

  void progressIndicator(Function() afterFinishFunction) {
    Timer.periodic(const Duration(milliseconds: 1400), (Timer timer) {
      timer.cancel();
      whenFinish(afterFinishFunction);
    });
  }

  void whenFinish(Function() clickButton) {
    changeIsLoading(newValueIsLoading: false);
    changeIsAnswered();
    clickButton();
  }
}
