import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

main(List<String> args) {
  runApp(Rootwidget());
}

class Rootwidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'calculator', home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String equation = '0';
  String result = '0';
  String expression = '0';

  buttonPressed(buttonText) {
    // print(buttonText);
    setState(
      () {
        if (buttonText == 'c') {
          equation = '0';
          result = '0';
        } else if (buttonText == '=') {
          expression = equation;
          expression = expression.replaceAll('x', '*');
          try {
            Parser p = Parser();
            Expression exp = p.parse(expression);
            ContextModel cm = ContextModel();
            result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          } catch (e) {
            result = 'Error';
          }
        } else if (buttonText == '⌫') {
          var oldEquation = equation;
          print(oldEquation.length);
          equation = oldEquation.substring(0, oldEquation.length - 1);
          if (oldEquation == '') {
            equation = '0';
          }
        } else {
          equation = buttonText;
          var newEquation = equation + buttonText;
          equation = newEquation;
        }
      },
    );
  }

  Widget keypadButton(buttonText, buttonColor) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(15),
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: () {
        buttonPressed(buttonText);
      },
      child: Text(
        buttonText,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget operatorButton(buttonText) {
    return TextButton(
      style: TextButton.styleFrom(
          padding: EdgeInsets.all(15),
          backgroundColor: Colors.blue,
          shape: CircleBorder()),
      onPressed: () {
        buttonPressed(buttonText);
      },
      child: Text(
        buttonText,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget deleteButton(buttonText) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.35,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(15),
          backgroundColor: Colors.cyan,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () {
          buttonPressed(buttonText);
        },
        child: Text(
          buttonText,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(30, 38, 53, 1),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  result,
                  style: TextStyle(color: Colors.white, fontSize: 32),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  equation,
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                Spacer(),
                Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          keypadButton('=', Colors.cyan),
                          keypadButton('c', Colors.cyan),
                          deleteButton('⌫'),
                        ]),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          keypadButton('7', Color.fromRGBO(40, 51, 73, 1)),
                          keypadButton('8', Color.fromRGBO(40, 51, 73, 1)),
                          keypadButton('9', Color.fromRGBO(40, 51, 73, 1)),
                          operatorButton('+'),
                        ]),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          keypadButton('4', Color.fromRGBO(40, 51, 73, 1)),
                          keypadButton('5', Color.fromRGBO(40, 51, 73, 1)),
                          keypadButton('6', Color.fromRGBO(40, 51, 73, 1)),
                          operatorButton('-'),
                        ]),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          keypadButton('1', Color.fromRGBO(40, 51, 73, 1)),
                          keypadButton('2', Color.fromRGBO(40, 51, 73, 1)),
                          keypadButton('3', Color.fromRGBO(40, 51, 73, 1)),
                          operatorButton('x'),
                        ]),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        keypadButton('0', Color.fromRGBO(40, 51, 73, 1)),
                        keypadButton('00', Color.fromRGBO(40, 51, 73, 1)),
                        keypadButton('.', Color.fromRGBO(40, 51, 73, 1)),
                        operatorButton('/'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
