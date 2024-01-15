import 'package:calculator/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQuestion = "";
  var userAnswer = "";
  final List<String> buttons = [
    "C",
    "DEL",
    " % ",
    " / ",
    "9",
    "8",
    "7",
    " x ",
    "6",
    "5",
    "4",
    " - ",
    "3",
    "2",
    "1",
    " + ",
    "0",
    ".",
    "ANS",
    " = ",
    // list of button names
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white10,
        body: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      userQuestion,
                      style: const TextStyle(fontSize: 30, color: Colors.white),
                      // question text
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userAnswer,
                      style: const TextStyle(fontSize: 40, color: Colors.white),
                      // answer text
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            userQuestion = "";
                          });
                        },
                        buttonText: buttons[index],
                        color: const Color.fromARGB(255, 127, 13, 5),
                        textColor: Colors.white,
                        //Clear button
                      );
                    } else if (index == 1) {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            userQuestion = userQuestion.substring(
                                0, userQuestion.length - 1);
                          });
                        },
                        buttonText: buttons[index],
                        color: const Color.fromARGB(255, 165, 21, 11),
                        textColor: Colors.white,
                        //DEL button
                      );
                    } else if (index == buttons.length - 2) {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            userQuestion += userAnswer;
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.deepPurpleAccent,
                        textColor: Colors.white,
                        // ANS button
                      );
                    } else if (index == buttons.length - 1) {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            equalPressed();
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.deepPurpleAccent,
                        textColor: Colors.white,
                        // = button
                      );
                    } else {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            userQuestion += buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        color: isOperator(buttons[index])
                            ? Colors.deepPurple
                            : Colors.deepPurple[50],
                        textColor: isOperator(buttons[index])
                            //determines if buttons[index] is an operator
                            ? Colors.white
                            //default text color
                            : Colors.deepPurple,
                        //text color if operator
                      );
                      //creates buttons
                    }
                  }),
            ),
          ],
        ));
  }

  bool isOperator(String x) {
    if (x == " % " || x == " / " || x == " x " || x == " - " || x == " + ") {
      return true;
    }
    return false;
  }
// determines what buttons are operators so the colors can be changed

  void equalPressed() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll("x", "*");

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
  }
}
//solves equasion and returns the answer