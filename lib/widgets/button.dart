import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String buttonText;
  final Function onPressed;

  MyButton({this.buttonText, this.color, this.textColor, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: MaterialButton(
          onPressed: onPressed,
          color: color,
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(color: textColor, fontSize: 20 ),
            ),
          ),
        ),
      ),
    );
  }
}
