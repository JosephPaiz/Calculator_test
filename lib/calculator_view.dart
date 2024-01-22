import 'package:flutter/material.dart';
import 'package:calculator_test/buttons.dart';
import 'package:calculator_test/style.dart';
import 'package:calculator_test/button_widget.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorState();
}

class _CalculatorState extends State<CalculatorView> {
  String n1 = '';
  String operand = '';
  String n2 = '';

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Style.backgroundColor,
      body: SafeArea(
        // bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //Results
            //
            //SupportResult
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  // color: Colors.purple,
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: Text(
                    // '0',
                    supportView(),
                    style: Style.secondaryResultStyle,
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),

            //
            //MainResult
            Expanded(
              flex: 0,
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  // color: Colors.green,
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    // '$n1$operand$n2',
                    mainView(),
                    style: Style.mainResultStyle,
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),
            //
            //Button panel
            Container(
              alignment: Alignment.center,
              // padding: EdgeInsets.only(bottom: 100),
              color: Colors.black,
              width: sizeScreen.width,
              height: sizeScreen.height / 1.8,
              child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                children: Btns.btnOrder
                    .map((value) => ButtonCalculator(
                        value: value, btnOnTap: () => btnOnTap(value)))
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  //view
  String mainView() {
    if (n1.isEmpty && n2.isEmpty) {
      return '0';
    } else if (n1.isNotEmpty && operand.isEmpty) {
      return n1;
    } else if (n1.isNotEmpty && operand.isNotEmpty && n2.isEmpty) {
      return n1;
    } else if (n1.isNotEmpty && operand.isNotEmpty && n2.isNotEmpty) {
      return n2;
    }
    return '';
  }

  String supportView() {
    if (n1.isNotEmpty && operand.isNotEmpty) {
      return '$n1 $operand';
    } else {
      return '';
    }
  }

  void toToggleSing() {
    setState(() {
      if (n1.isNotEmpty && operand.isEmpty) {
        if (n1.contains('-')) {
          n1 = n1.replaceAll('-', '');
        } else if (!n1.contains('-')) {
          n1 = '-$n1';
        }
      }

      if (n1.isNotEmpty && operand.isNotEmpty && n2.isNotEmpty) {
        if (n2.contains('-')) {
          n2 = n2.replaceAll('-', '');
        } else if (!n2.contains('-')) {
          n2 = '-$n2';
        }
      }
    });
  }

  void btnOnTap(String value) {
    if (value == Btns.allClear) {
      clearAll();
      return;
    }

    setValues(value);
  }

  void toCalculate() {
    if (n1.isEmpty) return;
    if (operand.isEmpty) return;
    if (n2.isEmpty) return;

    final double numb1 = double.parse(n1);
    final double numb2 = double.parse(n2);

    var result = 0.0;

    switch (operand) {
      case Btns.divide:
        result = numb1 / numb2;
        break;
      case Btns.multiply:
        result = numb1 * numb2;
        break;
      case Btns.subtract:
        result = numb1 - numb2;
        break;
      case Btns.add:
        result = numb1 + numb2;
        break;
    }

    setState(() {
      n1 = result.toStringAsPrecision(3);

      if (n1.endsWith('.0')) {
        n1 = n1.substring(0, n1.length - 2);
      } else if (n1.endsWith('.00')) {
        n1 = n1.substring(0, n1.length - 3);
      }

      operand = '';
      n2 = '';
    });
  }

  void toPercentage() {
    final nconvert = double.parse(n1);
    setState(() {
      n1 = "${(nconvert / 100)}";
      operand = '';
      n2 = '';
    });

    if (operand.isNotEmpty) {
      return;
    }

    if (n1.isNotEmpty && operand.isNotEmpty && n2.isNotEmpty) {
      toCalculate();
    }
  }

  void setValues(String value) {
    setState(() {
      if (value != Btns.dot && int.tryParse(value) == null) {
        if (value == Btns.equal &&
            n1.isNotEmpty &&
            operand.isNotEmpty &&
            n2.isNotEmpty) {
          toCalculate();
          return;
        }

        if (value == Btns.percent && n1.isNotEmpty) {
          toPercentage();
          return;
        }

        if (value == Btns.toggleSing) {
          toToggleSing();
          return;
        }

        if (n1.isNotEmpty && operand.isEmpty) {
          operand += value;
        }
      }
      if (n1.isEmpty || operand.isEmpty) {
        if (value == Btns.dot && n1.contains(Btns.dot)) return;

        if (int.tryParse(value) != null || value == Btns.dot) {
          if (value == Btns.dot && (n1.isEmpty || n1 == Btns.n0)) {
            n1 = '0.';
          } else {
            n1 += value;
          }
        }
      }
      if (n1.isNotEmpty && operand.isNotEmpty) {
        if (value == Btns.dot && n2.contains(Btns.dot)) return;

        if (int.tryParse(value) != null || value == Btns.dot) {
          if (value == Btns.dot && (n2.isEmpty || n2 == Btns.n0)) {
            n2 = '0.';
          } else {
            n2 += value;
          }
        }
      }
    });
  }

  void clearAll() {
    setState(() {
      n1 = '';
      operand = '';
      n2 = '';
    });
  }
}
