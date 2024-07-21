import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  Parser p = Parser();
  String result = "";
  final List<String> b = [
    'C',
    '+',
    '-',
    '%',
    'x',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '0',
    '='
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 100),
          SizedBox(
            width: double.infinity,
            child: Text(
              result == "" ? "0" : result,
              style: const TextStyle(
                  fontSize: 30, color: Color.fromARGB(255, 35, 215, 212)),
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(height: 60),
          const Divider(
            color: Color.fromARGB(255, 76, 73, 79),
            thickness: 2,
            height: 50,
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SizedBox(
              height: 400,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 50,
                    crossAxisSpacing: 20),
                itemCount: b.length,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    onPressed: () {
                      setState(() {
                        {
                          btnaction(index);
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        shadowColor: index < 4
                            ? const Color.fromARGB(237, 191, 0, 255)
                            : index >= 4 && index <= 8
                                ? const Color.fromARGB(221, 0, 255, 68)
                                : const Color.fromARGB(221, 0, 255, 187),
                        elevation: 400,
                        backgroundColor: index == 0
                            ? const Color.fromARGB(255, 178, 221, 112)
                            : index == b.length - 1
                                ? const Color.fromARGB(255, 177, 126, 50)
                                : index == 1 ||
                                        index == 2 ||
                                        index == 3 ||
                                        index == 4
                                    ? const Color.fromARGB(255, 81, 126, 205)
                                    : const Color.fromARGB(255, 52, 51, 48)),
                    child: Text(
                      b[index],
                      style: const TextStyle(
                          color: Color.fromARGB(221, 136, 184, 150),
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    ));
  }

  void btnaction(index) {
    ContextModel cm = ContextModel();
    if (index == 0) {
      result = "";
    } else if (index == 1 && result != "") {
      result += "+";
    } else if (index == 2 && result != "") {
      result += "-";
    } else if (index == 3 && result != "") {
      result += "/";
    } else if (index == 4 && result != "") {
      result += "x";
    } else if (index == b.length - 1) {
      Expression exp = p.parse(result);
      result = exp.evaluate(EvaluationType.REAL, cm).toString();
    } else {
      result += b[index];
    }
  }
}
