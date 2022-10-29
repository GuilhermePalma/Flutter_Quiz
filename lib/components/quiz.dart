import 'dart:async';

import 'package:flutter/material.dart';

import '../model/entities/quiz_entity.dart';
import '../model/view/quiz_view.dart';
import 'button_answer.dart';

class Quiz extends StatefulWidget {
  final QuizEntity quizEntity;
  final int index;
  final void Function(dynamic) clickButton;
  final List<QuizView> questions;

  const Quiz({
    Key? key,
    required this.index,
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

  double _timeLeft = 1;

  void changeIsAnswered() => setState(() => isAnswered = !isAnswered);

  void changeIsLoading({bool newValueIsLoading = false}) =>
      setState(() => isLoading = newValueIsLoading);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _getRow,
                ),
                LinearProgressIndicator(
                  value: _timeLeft,
                  color: Colors.blue[250],
                ),
                Container(
                  height: 1,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.35),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 8, 8),
                  child: Text(
                    "${widget.index}. ${widget.quizEntity.question}",
                    style: const TextStyle(
                      fontSize: 28,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(height: 16),
                Column(children: _getResponsesButtons()),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget get _getRow => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              "Quiz APP",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          Card(
            color: Colors.blue[300],
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
              child: Row(
                children: [
                  Text(
                    "Time",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[850],
                    ),
                  ),
                  const SizedBox(width: 6),
                  Card(
                    color: Colors.grey[850],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 16,
                      ),
                      child: Text(
                        _timeLeft.round().toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );

  List<Widget> _getResponsesButtons() => widget.questions
      .map((e) => Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
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
