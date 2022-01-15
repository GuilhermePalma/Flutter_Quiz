import 'package:flutter/material.dart';

class ButtonAnswer extends StatelessWidget {
  final String text;
  final void Function() functionPressed;

  ButtonAnswer(this.text, this.functionPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: ElevatedButton(
        onPressed: functionPressed,
        child: Text(
          text,
        ),
      ),
    );
  }
}
