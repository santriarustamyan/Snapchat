import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewUser extends StatelessWidget {
  final head;
  final val;
  ViewUser({this.head, this.val});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        head,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 20,
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 5, bottom: 20),
        child: RichText(
          text: TextSpan(
            text: val,
            style: TextStyle(
              color: Colors.blue,
              fontSize: 15,
            ),
          ),
        ),
      ),
    ]);
  }
}
