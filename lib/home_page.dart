import 'package:flutter/material.dart';

import 'package:my_calculator/properties.dart';
import 'package:math_expressions/math_expressions.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String input = '', output = '';
  bool isDarkMode = true;

  Color greenColor = Color(0xff40E0D0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xff28282B) : Colors.white,
      bottomNavigationBar: SizedBox(
        height: 30,
        child: Container(
          color: isDarkMode ? Colors.black26 : Colors.grey.shade100,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            children: [
              DarkLight(),
              Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.all(20),
                child: Text(
                  input,
                  style: TextStyle(
                      fontSize: 24,
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.all(20),
                child: Text(
                  output,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontSize: 36,
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              color: isDarkMode ? Colors.black26 : Colors.grey.shade100,
            ),
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    button(num: "AC"),
                    button(num: "%"),
                    button(num: ""),
                    button(num: "/")
                  ],
                ),
                Row(
                  children: [
                    button(num: "7"),
                    button(num: "8"),
                    button(num: "9"),
                    button(num: "X")
                  ],
                ),
                Row(
                  children: [
                    button(num: "4"),
                    button(num: "5"),
                    button(num: "6"),
                    button(num: "-")
                  ],
                ),
                Row(
                  children: [
                    button(num: "1"),
                    button(num: "2"),
                    button(num: "3"),
                    button(num: "+")
                  ],
                ),
                Row(
                  children: [
                    button(num: Icons.rotate_left),
                    button(num: "0"),
                    button(num: "."),
                    button(num: "=")
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onButtonClick(number) {
    if (number == "AC") {
      input = '';
      output = '';
      setState(() {});
    } else if (number == "=") {
      var userInput = input;
      userInput = input.replaceAll("X", "*");
      Parser p = Parser();
      Expression expression = p.parse(userInput);
      ContextModel cm = ContextModel();
      var result = expression.evaluate(EvaluationType.REAL, cm);
      output = result.toString();
      if (output.endsWith(".0")) {
        output = output.substring(0, output.length - 2);
      }
      setState(() {});
    } else {
      input = input + number;
      setState(() {});
    }
  }

  Widget DarkLight() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          clipBehavior: Clip.antiAlias,
          onPressed: () {
            isDarkMode = false;
            setState(() {});
          },
          child: Icon(Icons.light_mode,
              color: isDarkMode ? Colors.grey : Colors.black),
          style: ElevatedButton.styleFrom(
              animationDuration: Duration(seconds: 0),
              elevation: 0,
              backgroundColor:
                  isDarkMode ? Colors.black26 : Colors.grey.shade100,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12)))),
        ),
        ElevatedButton(
          onPressed: () {
            isDarkMode = true;
            setState(() {});
          },
          child: Icon(
            Icons.dark_mode,
            color: isDarkMode ? Colors.white : Colors.grey,
          ),
          style: ElevatedButton.styleFrom(
              elevation: 0,
              animationDuration: Duration(seconds: 0),
              backgroundColor:
                  isDarkMode ? Colors.black26 : Colors.grey.shade100,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12)))),
        )
      ],
    );
  }

  Widget button({num}) {
    if (num == "AC" || num == "%") {
      tColor = greenColor;
    } else if (num == "/" ||
        num == "X" ||
        num == "-" ||
        num == "+" ||
        num == "=") {
      tColor = orangeColor;
    } else {
      tColor = isDarkMode ? Colors.white : Colors.black;
    }

    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: ElevatedButton(
        onPressed: () => onButtonClick(num),
        child: num is String
            ? Text(
                num,
                style: TextStyle(
                    color: tColor, fontWeight: FontWeight.bold, fontSize: 22),
              )
            : Icon(
                num,
                color: tColor,
              ),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: isDarkMode ? Colors.black12 : Colors.grey.shade200,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          fixedSize: Size(50, 65),
        ),
      ),
    ));
  }
}
