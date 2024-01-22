import 'package:flutter/material.dart';
import 'package:calculator_test/resources/style.dart';
import 'package:calculator_test/resources/buttons.dart';

class ButtonCalculator extends StatefulWidget {
  const ButtonCalculator(
      {super.key, required this.value, required this.btnOnTap});
  final String value;
  // ignore: prefer_typing_uninitialized_variables
  final btnOnTap;
  @override
  State<ButtonCalculator> createState() => _ButtonCalculatorState();
}

class _ButtonCalculatorState extends State<ButtonCalculator> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.btnOnTap,
      //Padding
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            4, widget.value == Btns.allClear ? 19 : 4, 4, 4),
        //MainContinaer
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(widget.value == Btns.allClear ? 10 : 15),
            color: Style.backgroundColorBtn,
          ),
          height: widget.value == Btns.allClear ? 55 : 87,
          width: Btns.numAndDot.contains(widget.value)
              ? 75
              : widget.value == Btns.allClear
                  ? 70
                  : 100,
          //DecorationContainer
          child: Btns.numAndDot.contains(widget.value)
              ? Text(widget.value, style: Style.btnTextStyle)
              : widget.value == Btns.allClear
                  ? Text(widget.value, style: Style.btnTextStyle)
                  : [Btns.toggleSing, Btns.percent].contains(widget.value)
                      ? Text(widget.value, style: Style.btnTextStyle)
                      : Material(
                          borderRadius: BorderRadius.circular(100),
                          color: Style.textColorbtn,
                          child: SizedBox(
                            height: 45,
                            width: 45,
                            child: Center(
                              child: Text(
                                widget.value,
                                style: const TextStyle(
                                    fontSize: 36,
                                    color: Color(0xFF262628),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
        ),
      ),
    );
  }
}
