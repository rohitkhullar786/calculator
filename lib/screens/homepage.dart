import 'package:calculator/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userQuestion = '';
  String answer = '0';
  String lastAnswer;

  List<String> buttons = [
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
    '='
  ];

  bool isOperator(String x) {
    if (x == '+' || x == '-' || x == '/' || x == 'x' || x == '%' || x == '=') {
      return true;
    } else {
      return false;
    }
  }

  void calculate() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);

    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
    lastAnswer = answer;
  }

  String ans() {
    return lastAnswer;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          userQuestion,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 50,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          answer,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 50,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    
                      crossAxisCount: 4),
                  itemBuilder: (context, int index) {
                    //Clear Button
                    if (index == 0) {
                      return MyButton(
                        color: Colors.teal,
                        buttonText: buttons[index],
                        textColor: Colors.white,
                        onPressed: () {
                          setState(() {
                            userQuestion = '';
                            answer = '0';
                          });
                        },
                      );
                    }
                    //Del Button
                    else if (index == 1) {
                      return MyButton(
                        color: Colors.red,
                        buttonText: buttons[index],
                        textColor: Colors.white,
                        onPressed: () {
                          setState(() {
                            userQuestion = userQuestion.substring(
                                0, userQuestion.length - 1);
                          });
                        },
                      );
                    }
                    // //ANS Button
                    else if (index == buttons.length - 2) {
                      return MyButton(
                        color: Colors.deepPurple,
                        buttonText: buttons[index],
                        textColor: Colors.white,
                        onPressed: () {
                          setState(() {
                            answer = ans();
                          });
                        },
                      );
                    }
                    //Equal button
                    else if (index == buttons.length - 1) {
                      return MyButton(
                        color: Colors.deepPurple,
                        buttonText: buttons[index],
                        textColor: Colors.white,
                        onPressed: () {
                          setState(() {
                            if (userQuestion.isNotEmpty) {
                              calculate();
                            }
                          });
                        },
                      );
                    } else {
                      return MyButton(
                        buttonText: buttons[index],
                        color: isOperator(buttons[index])
                            ? Colors.deepPurple
                            : Colors.deepPurple[50],
                        textColor: isOperator(buttons[index])
                            ? Colors.white
                            : Colors.deepPurple,
                        onPressed: () {
                          setState(() {
                            userQuestion += buttons[index];
                          });
                        },
                      );
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
