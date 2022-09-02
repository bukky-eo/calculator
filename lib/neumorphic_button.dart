import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String buttonText;
  final Color buttonColor, textColor;
  final Function() onTap;

  const Button(
      {Key? key,
      required this.textColor,
      required this.buttonColor,
      required this.onTap,
      required this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade700,
                    offset: Offset(4, 4),
                    blurRadius: 15,
                    spreadRadius: 1),
                const BoxShadow(
                    color: Colors.white,
                    offset: Offset(-4, -4),
                    blurRadius: 15,
                    spreadRadius: 1)
              ]),
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(fontSize: 30, color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
// Colors.grey.shade700
// Colors.grey.shade300
