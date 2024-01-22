import 'package:flutter/material.dart';
import 'package:calculator_test/resources/buttons.dart';
import 'package:calculator_test/resources/style.dart';
import 'package:calculator_test/widgets/button_widget.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorState();
}

class _CalculatorState extends State<CalculatorView> {
  String firstInput = '';
  String operand = '';
  String secondInput = '';

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
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: Text(
                    supportView(),
                    style: Style.secondaryResultStyle,
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),
            //MainResult
            Expanded(
              flex: 0,
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
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
    // if (firstInput.isEmpty && secondInput.isEmpty) {
    //   return '0';
    // } else if (firstInput.isNotEmpty && operand.isEmpty) {
    //   return firstInput;
    // } else if (firstInput.isNotEmpty &&
    //     operand.isNotEmpty &&
    //     secondInput.isEmpty) {
    //   return firstInput;
    // } else if (firstInput.isNotEmpty &&
    //     operand.isNotEmpty &&
    //     secondInput.isNotEmpty) {
    //   return secondInput;
    // }

    if (firstInput.isEmpty && secondInput.isEmpty) {
      return '0';
    } else if (firstInput.isNotEmpty && secondInput.isEmpty) {
      return firstInput;
    } else if (firstInput.isNotEmpty &&
        operand.isNotEmpty &&
        secondInput.isNotEmpty) {
      return secondInput;
    }
    return '';
  }

  String supportView() {
    if (firstInput.isNotEmpty && operand.isNotEmpty) {
      return '$firstInput $operand';
    } else {
      return '';
    }
  }

  void toToggleSing() {
    setState(() {
      if (firstInput.isNotEmpty && operand.isEmpty) {
        if (firstInput.contains('-')) {
          firstInput = firstInput.replaceAll('-', '');
        } else if (!firstInput.contains('-')) {
          firstInput = '-$firstInput';
        }
      }

      if (firstInput.isNotEmpty &&
          operand.isNotEmpty &&
          secondInput.isNotEmpty) {
        if (secondInput.contains('-')) {
          secondInput = secondInput.replaceAll('-', '');
        } else if (!secondInput.contains('-')) {
          secondInput = '-$secondInput';
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
    if (firstInput.isEmpty) return;
    if (operand.isEmpty) return;
    if (secondInput.isEmpty) return;

    final double convertFirstInput = double.parse(firstInput);
    final double convertSecondInput = double.parse(secondInput);

    var result = 0.0;

    switch (operand) {
      case Btns.divide:
        result = convertFirstInput / convertSecondInput;
        break;
      case Btns.multiply:
        result = convertFirstInput * convertSecondInput;
        break;
      case Btns.subtract:
        result = convertFirstInput - convertSecondInput;
        break;
      case Btns.add:
        result = convertFirstInput + convertSecondInput;
        break;
    }

    setState(() {
      firstInput = result.toStringAsPrecision(3);

      if (firstInput.endsWith('.0')) {
        firstInput = firstInput.substring(0, firstInput.length - 2);
      } else if (firstInput.endsWith('.00')) {
        firstInput = firstInput.substring(0, firstInput.length - 3);
      }

      operand = '';
      secondInput = '';
    });
  }

  void toPercentage() {
    final nconvert = double.parse(firstInput);
    setState(() {
      firstInput = "${(nconvert / 100)}";
      operand = '';
      secondInput = '';
    });

    if (operand.isNotEmpty) {
      return;
    }

    if (firstInput.isNotEmpty && operand.isNotEmpty && secondInput.isNotEmpty) {
      toCalculate();
    }
  }

  void setValues(String value) {
    setState(() {
      if (value != Btns.dot && int.tryParse(value) == null) {
        if (value == Btns.equal &&
            firstInput.isNotEmpty &&
            operand.isNotEmpty &&
            secondInput.isNotEmpty) {
          toCalculate();
          return;
        }

        if (value == Btns.percent && firstInput.isNotEmpty) {
          toPercentage();
          return;
        }

        if (value == Btns.toggleSing) {
          toToggleSing();
          return;
        }

        if (firstInput.isNotEmpty && operand.isEmpty) {
          operand += value;
        }
      }
      if (firstInput.isEmpty || operand.isEmpty) {
        if (value == Btns.dot && firstInput.contains(Btns.dot)) return;

        if (int.tryParse(value) != null || value == Btns.dot) {
          if (value == Btns.dot &&
              (firstInput.isEmpty || firstInput == Btns.n0)) {
            firstInput = '0.';
          } else {
            firstInput += value;
          }
        }
      }
      if (firstInput.isNotEmpty && operand.isNotEmpty) {
        if (value == Btns.dot && secondInput.contains(Btns.dot)) return;

        if (int.tryParse(value) != null || value == Btns.dot) {
          if (value == Btns.dot &&
              (secondInput.isEmpty || secondInput == Btns.n0)) {
            secondInput = '0.';
          } else {
            secondInput += value;
          }
        }
      }
    });
  }

  void clearAll() {
    setState(() {
      firstInput = '';
      operand = '';
      secondInput = '';
    });
  }
}
