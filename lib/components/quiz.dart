import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz/components/custom_text.dart';
import 'package:quiz/components/shadow_line.dart';

import '../model/entities/quiz_entity.dart';
import '../model/view/quiz_view.dart';
import 'button_answer.dart';

class Quiz extends StatefulWidget {
  final QuizEntity quizEntity;
  final int index;
  final void Function(dynamic) clickButton;
  final List<QuizView> questions;
  final double maxTimeToResponse;

  const Quiz({
    Key? key,
    this.maxTimeToResponse = 10,
    required this.index,
    required this.quizEntity,
    required this.clickButton,
    required this.questions,
  }) : super(key: key);

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  bool? isAnswered;
  bool? isLoading;
  List<ButtonAnswer>? values;
  double? _secondsLeft;

  /// Called once: When create Widget in Widget Tree
  @override
  void initState() {
    super.initState();
    refreshInternalTimer();
  }

  /// Called whenever the parent widget state is updated
  @override
  void didUpdateWidget(Quiz oldWidget) {
    super.didUpdateWidget(oldWidget);
    refreshInternalTimer();
  }

  void refreshInternalTimer() {
    _secondsLeft = widget.maxTimeToResponse;
    isAnswered = false;
    isLoading = false;
    computeAnswerTime();
  }

  void changeIsAnswered() => setState(
      () => isAnswered = (isAnswered == null) ? false : !(isAnswered!));

  void changeIsLoading({bool newValueIsLoading = false}) =>
      setState(() => isLoading = newValueIsLoading);

  void computeAnswerTime() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      // Not compute time after select the response
      if (isAnswered != null && isAnswered!) {
        timer.cancel();
      } else {
        setState(() => _secondsLeft = ((_secondsLeft ?? 0) - 1));
      }

      if ((_secondsLeft ?? 0) <= 0) {
        timer.cancel();
        _whenAnswer(() => widget.clickButton(false));
      }
    });
  }

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
                  padding: const EdgeInsets.all(10),
                  child: _headerForm,
                ),
                LinearProgressIndicator(
                  value: (widget.maxTimeToResponse - (_secondsLeft ?? 0)) /
                      widget.maxTimeToResponse,
                  color: Colors.green,
                ),
                const ShadowLine(),
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

  Widget get _headerForm => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CustomText(
            "Quiz APP",
            padding: EdgeInsets.only(left: 8),
            textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          _getTimeBox,
        ],
      );

  Widget get _getTimeBox => Card(
      color: Colors.blue[300],
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
        child: Row(
          children: [
            CustomText("Time",
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[850],
                )),
            const SizedBox(width: 6),
            _getNumberBox,
          ],
        ),
      ));

  Widget get _getNumberBox => Card(
        color: Colors.grey[850],
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 16,
          ),
          child: CustomText(_secondsLeft!.round().toString(),
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
        ),
      );

  List<Widget> _getResponsesButtons() => widget.questions
      .map((e) => Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
            child: ButtonAnswer(
              text: e.question,
              isCorrectAnswer: e.isCorrect,
              isAnswered: isAnswered ?? false,
              isLoading: isLoading ?? false,
              functionPressed: () =>
                  _whenAnswer(() => widget.clickButton(e.isCorrect)),
            ),
          ))
      .toList();

  void _whenAnswer(Function() clickButton) {
    changeIsAnswered();
    changeIsLoading(newValueIsLoading: true);
    delayBeforeNextQuestion(clickButton);
  }

  void delayBeforeNextQuestion(Function() afterFinishFunction) {
    Timer.periodic(const Duration(milliseconds: 1400), (Timer timer) {
      timer.cancel();
      changeIsLoading(newValueIsLoading: false);
      changeIsAnswered();
      afterFinishFunction();
    });
  }
}
