import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return calc();
  }
}

class calc extends StatefulWidget {
  const calc({Key? key}) : super(key: key);

  @override
  State<calc> createState() => _calcState();
}

class _calcState extends State<calc> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double euationsize = 30;
  double resultsize = 90;

  buttonpressed(String buttontext) {
    setState(() {
      if (buttontext == "AC") {
        euationsize = 30;
        resultsize = 60;
        equation = "0";
        result = "0";
      } else if (buttontext == "=") {
        euationsize = 30;
        resultsize = 60;

        expression = equation;
        try {
          Parser p = new Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = "${exp.evaluate(EvaluationType.REAL, cm)}";
        } catch (e) {
          result = "Error";
        }
      } else if (buttontext == "⌫") {
        equation = equation.substring(0, equation.length - 1);
      } else {
        euationsize = 60;
        resultsize = 30;
        if (equation == "0") {
          equation = buttontext;
        } else {
          equation = equation + buttontext;
        }
      }
    });
  }

  Widget button(String buttontext, Color colors) {
    return Expanded(
      child: InkWell(
        onTap: () {
          buttonpressed(buttontext);
        },
        child: Container(
          height: 66,
          width: 170,
          child: Center(
              child: Text(
            buttontext,
            style: TextStyle(fontSize: 30, color: colors),
          )),
        ),
      ),
    );
  }

  Widget acbutton(String buttontext) {
    return InkWell(
      onTap: () {
        buttonpressed(buttontext);
      },
      child: Container(
        height: 66,
        width: 170,
        decoration: BoxDecoration(
          color: Color(0xffFF5A66),
          borderRadius: BorderRadius.circular(60),
        ),
        child: Center(
            child: Text(
          buttontext,
          style: TextStyle(color: Colors.white, fontSize: 30),
        )),
      ),
    );
  }

  Widget equalto(String buttontext) {
    return Expanded(
      child: InkWell(
        onTap: () {
          buttonpressed(buttontext);
        },
        child: Container(
          height: 90,
          width: 200,
          child: Center(
            child: Text(
              buttontext,
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
          decoration: BoxDecoration(
            color: Color(0xffFF5A66),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 50),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    equation,
                    style:
                        TextStyle(fontSize: euationsize, color: Colors.black54),
                  ),
                  SizedBox(
                    height: 20,
                    width: 10,
                  ),
                ],
              ),
            ),
            Text(
              result,
              style: TextStyle(fontSize: resultsize, color: Colors.black),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Divider(
                thickness: 2,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      acbutton("AC"),
                      button("⌫", Colors.black54),
                      button("/", Color(0xffFF5A66)),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      button("7", Colors.black),
                      button("8", Colors.black),
                      button("9", Colors.black),
                      button("*", Color(0xffFF5A66)),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      button("4", Colors.black),
                      button("5", Colors.black),
                      button("6", Colors.black),
                      button("-", Color(0xffFF5A66)),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      button("1", Colors.black),
                      button("2", Colors.black),
                      button("3", Colors.black),
                      button("+", Color(0xffFF5A66)),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      button("00", Colors.black),
                      button("0", Colors.black),
                      button(".", Colors.black),
                      equalto("=")
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
