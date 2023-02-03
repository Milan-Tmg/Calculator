// ignore_for_file: camel_case_types, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(calculator());
}

class calculator extends StatelessWidget {
  const calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      home: mycalculator(),
      theme: ThemeData(primarySwatch: Colors.blueGrey),
    );
  }
}

class mycalculator extends StatefulWidget {
  const mycalculator({super.key});

  @override
  State<mycalculator> createState() => _mycalculatorState();
}

String equation = '0';
String result = '0';
String expression = '';
double equationfontsize = 38.0;
double resultfontsize = 48.0;

class _mycalculatorState extends State<mycalculator> {
  buttonpressed(String buttontext) {
    setState(
      () {
        if (buttontext == 'C') {
          equationfontsize = 38.0;
          resultfontsize = 48.0;
          equation = '0';
          result = '0';
        } else if (buttontext == '⌫') {
          equationfontsize = 48.0;
          resultfontsize = 38.0;
          equation = equation.substring(0, equation.length - 1);
          if (equation == '') {
            equationfontsize = 38.0;
            resultfontsize = 48.0;
            equation = '0';
          }
        } else if (buttontext == '=') {
          equationfontsize = 38.0;
          resultfontsize = 48.0;
          expression = equation;
          expression = expression.replaceAll('×', '*');
          expression = expression.replaceAll('÷', '/');
          try {
            Parser p = Parser();
            Expression exp = p.parse(expression);
            ContextModel cm = ContextModel();
            result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          } catch (e) {
            result = 'Error';
          }
        } else {
          equationfontsize = 38.0;
          resultfontsize = 48.0;
          if (equation == '0') {
            equation = buttontext;
          } else {
            equation = equation + buttontext;
          }
        }
      },
    );
  }

  Widget buildButtom(
      String buttontext, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: TextButton(
        style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
              side: BorderSide(
                  color: Colors.white, width: 1, style: BorderStyle.solid),
            ),
            padding: EdgeInsets.all(16)),
        onPressed: (() => buttonpressed(buttontext)),
        child: Text(
          buttontext,
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple calculator'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationfontsize, color: Colors.black),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultfontsize, color: Colors.black),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButtom('C', 1, Colors.redAccent),
                        buildButtom('⌫', 1, Colors.blue),
                        buildButtom('÷', 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButtom('7', 1, Colors.black54),
                        buildButtom('8', 1, Colors.black54),
                        buildButtom('9', 1, Colors.black54),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButtom('4', 1, Colors.black54),
                        buildButtom('5', 1, Colors.black54),
                        buildButtom('6', 1, Colors.black54),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButtom('1', 1, Colors.black54),
                        buildButtom('2', 1, Colors.black54),
                        buildButtom('3', 1, Colors.black54),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButtom('.', 1, Colors.black54),
                        buildButtom('0', 1, Colors.black54),
                        buildButtom('00', 1, Colors.black54),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButtom('×', 1, Colors.blue),
                    ]),
                    TableRow(children: [
                      buildButtom('-', 1, Colors.blue),
                    ]),
                    TableRow(
                      children: [
                        buildButtom('+', 1, Colors.blue),
                      ],
                    ),
                    TableRow(children: [
                      buildButtom('=', 2, Colors.redAccent),
                    ]),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
