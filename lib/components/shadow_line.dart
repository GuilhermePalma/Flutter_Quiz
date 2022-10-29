import 'package:flutter/material.dart';

class ShadowLine extends StatelessWidget {
  final double opacity;
  final double height;
  final double spreadRadius;
  final double blurRadius;

  const ShadowLine({
    this.height = 1.0,
    this.opacity = 0.35,
    this.spreadRadius = 5.0,
    this.blurRadius = 7.0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(opacity),
            spreadRadius: spreadRadius,
            blurRadius: blurRadius,
            offset: const Offset(0, 1),
          ),
        ],
      ),
    );
  }
}
