import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SeeMoreText extends StatelessWidget {
  SeeMoreText(this.title, {this.textColor = Colors.white});
  final String title;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            color: textColor));
  }
}
