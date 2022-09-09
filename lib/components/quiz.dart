import 'package:flutter/material.dart';

import 'buttonAnswer.dart';
import 'customText.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> listQuestions;
  final int indexSelected;
  final void Function(int) clickButton;

  const Quiz({
    required this.listQuestions,
    required this.indexSelected,
    required this.clickButton,
  });

  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> responses =
        listQuestions[indexSelected].cast()['response'];

    return Column(
      children: [
        CustomText(
          listQuestions[indexSelected]['question'].toString(),
        ),
        ...responses.map((response) {
          return ButtonAnswer(
            response['text'].toString(),
            () => clickButton(int.parse(response['value'].toString())),
          );
        }),
      ],
    );
  }
}
