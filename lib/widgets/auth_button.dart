import 'package:flutter/material.dart';

class TextAuthButton extends StatelessWidget {
  final Color? color;
  final String text;
  final Function()? onPress;

  TextAuthButton({
    this.color,
    required this.text,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.fromLTRB(1, 1, 1, 1),
        height: 100,
        width: double.infinity,
        color: color,
        child: TextButton(
          onPressed: onPress,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
