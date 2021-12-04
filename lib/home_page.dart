import 'package:flutter/material.dart';
import 'package:flutter_calculator/models/my_button.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    '×',
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
  TextStyle upperTextStyle = TextStyle(fontSize: 35);

  String question = '';
  String answer = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        question,
                        style: upperTextStyle,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        answer,
                        style: upperTextStyle,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemCount: buttons.length,
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return MyButton(
                        onPressed: () {
                          setState(() {
                            question = '';
                            answer = '';
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.green,
                        textColor: Colors.white,
                      );

                      // DEL button
                    } else if (index == 1) {
                      return MyButton(
                        onPressed: () {
                          setState(() {
                            question =
                                question.substring(0, (question.length - 1));
                          });
                        },
                        buttonText: buttons[1],
                        color: Colors.red,
                        textColor: Colors.white,
                      );

                      // = button
                    } else if (index == buttons.length - 1) {
                      return MyButton(
                          onPressed: () {
                            setState(() {
                              equalPressed();
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.deepPurple,
                          textColor: Colors.white);

                      // rest of the buttons
                    } else {
                      return MyButton(
                        onPressed: () {
                          setState(() {
                            question += buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        color: isOperator(buttons[index])
                            ? Colors.deepPurple
                            : Colors.deepPurple.shade50,
                        textColor: isOperator(buttons[index])
                            ? Colors.white
                            : Colors.deepPurple,
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static bool isOperator(String x) {
    if (x == '%' || x == '/' || x == '×' || x == '+' || x == '-' || x == '=') {
      return true;
    }
    return false;
  }

  equalPressed() {
    String finalQuestion = question;
    finalQuestion = finalQuestion.replaceAll('×', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();

    // Evaluate expression:
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    answer = eval.toString();
  }
}
