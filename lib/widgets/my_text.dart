import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign? textAlign;
  const MyText({
    super.key,
    required this.text,
    required this.fontSize,
    required this.color,
    required this.fontWeight,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.start,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ),
    );
  }
}
