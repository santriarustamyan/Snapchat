import 'package:flutter/material.dart';

class ContinueButton extends StatelessWidget {
  final Color? color;
  final Function()? onPress;
  final String text;
  final Decoration? decoration;

  ContinueButton({
    this.color,
    this.onPress,
    required this.text,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 55,
        width: 260,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(50)),
        child: TextButton(
          onPressed: onPress,
          child: Text(
            text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              )),
        ),
      ),
    );
  }
}
