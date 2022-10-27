import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;

  CustomText(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 28,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
