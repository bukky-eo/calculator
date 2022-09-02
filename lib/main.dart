import 'package:calculator/neumorphic_button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const CalculatorView());
}

class CalculatorView extends StatelessWidget {
  const CalculatorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var userAnswer = '';
  var userQuestion = '';
  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Column(
        children: [
          Expanded(
              child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 25),
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    userQuestion,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userAnswer,
                    style: TextStyle(fontSize: 15),
                  ),
                )
              ],
            ),
          )),
          Expanded(
              flex: 4,
              child: Container(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemCount: buttons.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Button(
                        onTap: () {
                          setState(() {
                            userQuestion = '';
                          });
                        },
                        buttonText: buttons[index],
                        textColor: isOperator(buttons[index])
                            ? Colors.black
                            : Colors.white,
                        buttonColor: isOperator(buttons[index])
                            ? Colors.grey.shade800
                            : Colors.teal,
                      );
                    } else if (index == 1) {
                      return Button(
                        onTap: () {
                          setState(() {
                            userQuestion = userQuestion.substring(
                                0, userQuestion.length - 1);
                          });
                        },
                        buttonText: buttons[index],
                        textColor: isOperator(buttons[index])
                            ? Colors.black
                            : Colors.white,
                        buttonColor: isOperator(buttons[index])
                            ? Colors.white
                            : Colors.red,
                      );
                    } else if (index == buttons.length - 1) {
                      return Button(
                        onTap: () {
                          setState(() {
                            equalPressed();
                          });
                        },
                        buttonText: buttons[index],
                        textColor: isOperator(buttons[index])
                            ? Colors.white
                            : Colors.black,
                        buttonColor: isOperator(buttons[index])
                            ? Colors.grey.shade800
                            : Colors.white,
                      );
                    } else {
                      return Button(
                        onTap: () {
                          setState(() {
                            userQuestion += buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        textColor: isOperator(buttons[index])
                            ? Colors.white
                            : Colors.grey.shade700,
                        buttonColor: isOperator(buttons[index])
                            ? Colors.grey.shade600
                            : Colors.grey.shade300,
                      );
                    }
                  },
                ),
              ))
        ],
      ),
    );
  }

  bool isOperator(String value) {
    if (value == '/' ||
        value == '-' ||
        value == '+' ||
        value == '%' ||
        value == 'x' ||
        value == '%' ||
        value == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
  }
}
