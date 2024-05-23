import 'package:flutter/material.dart';
import 'package:calculator_test/resources/buttons.dart';
import 'package:calculator_test/resources/style.dart';
import 'package:calculator_test/widgets/button_widget.dart';
import 'package:calculator_test/models/calculator_model.dart';
import 'package:provider/provider.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorState();
}

class _CalculatorState extends State<CalculatorView> {
  @override
  Widget build(BuildContext context) {
    CalculatorModel calculatorModel = context.watch<CalculatorModel>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Style.backgroundColor,
        body: Column(
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
                    calculatorModel.supportView(),
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
                    calculatorModel.mainView(),
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
              child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                children: Btns.btnOrder
                    .map((value) => ButtonCalculator(
                        value: value,
                        btnOnTap: () => calculatorModel.btnOnTap(value)))
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
