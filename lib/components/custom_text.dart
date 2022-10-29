import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final TextAlign? textAlign;

  const CustomText(
    this.text, {
    Key? key,
    this.padding,
    this.textStyle,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (padding == null)
        ? _getText
        : Padding(padding: const EdgeInsets.only(left: 10), child: _getText);
  }

  Widget get _getText => Text(
        text,
        style: textStyle,
        textAlign: textAlign,
      );
}
