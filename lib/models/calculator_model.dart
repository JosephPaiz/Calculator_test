import 'package:calculator_test/resources/buttons.dart';
import 'package:flutter/material.dart';

class CalculatorModel with ChangeNotifier {
  String _firstInput = '';
  String _operand = '';
  String _secondInput = '';

  String get firstInput => _firstInput;
  String get operand => _operand;
  String get secondInput => _secondInput;

  String mainView() {
    if (_firstInput.isEmpty && _secondInput.isEmpty) {
      return '0';
    } else if (_firstInput.isNotEmpty && _secondInput.isEmpty) {
      return _firstInput;
    } else if (_firstInput.isNotEmpty &&
        _operand.isNotEmpty &&
        _secondInput.isNotEmpty) {
      return _secondInput;
    }
    return '';
  }

  String supportView() {
    if (_firstInput.isNotEmpty && _operand.isNotEmpty) {
      return '$_firstInput $_operand';
    } else {
      return '';
    }
  }

  void btnOnTap(String value) {
    if (value == Btns.allClear) {
      clearAll();
      return;
    }

    setValues(value);
    notifyListeners();
  }

  void toCalculate() {
    if (_firstInput.isEmpty) return;
    if (_operand.isEmpty) return;
    if (_secondInput.isEmpty) return;

    final double convertFirstInput = double.parse(_firstInput);
    final double convertSecondInput = double.parse(_secondInput);

    var result = 0.0;

    switch (_operand) {
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

    _firstInput = result.toStringAsPrecision(3);

    if (_firstInput.endsWith('.0')) {
      _firstInput = _firstInput.substring(0, _firstInput.length - 2);
    } else if (_firstInput.endsWith('.00')) {
      _firstInput = _firstInput.substring(0, _firstInput.length - 3);
    }

    _operand = '';
    _secondInput = '';

    notifyListeners();
  }

  void toPercentage() {
    final nconvert = double.parse(_firstInput);
    _firstInput = "${(nconvert / 100)}";
    _operand = '';
    _secondInput = '';

    if (_operand.isNotEmpty) {
      return;
    }

    if (_firstInput.isNotEmpty &&
        _operand.isNotEmpty &&
        _secondInput.isNotEmpty) {
      toCalculate();
    }
    notifyListeners();
  }

  void toToggleSing() {
    if (_firstInput.isNotEmpty && _operand.isEmpty) {
      if (_firstInput.contains('-')) {
        _firstInput = _firstInput.replaceAll('-', '');
      } else if (!_firstInput.contains('-')) {
        _firstInput = '-$_firstInput';
      }
    }

    if (_firstInput.isNotEmpty &&
        _operand.isNotEmpty &&
        _secondInput.isNotEmpty) {
      if (_secondInput.contains('-')) {
        _secondInput = _secondInput.replaceAll('-', '');
      } else if (!_secondInput.contains('-')) {
        _secondInput = '-$secondInput';
      }
    }
    notifyListeners();
  }

  void setValues(String value) {
    if (value != Btns.dot && int.tryParse(value) == null) {
      if (value == Btns.equal &&
          _firstInput.isNotEmpty &&
          _operand.isNotEmpty &&
          _secondInput.isNotEmpty) {
        toCalculate();
        return;
      }

      if (value == Btns.percent && _firstInput.isNotEmpty) {
        toPercentage();
        return;
      }

      if (value == Btns.toggleSing) {
        toToggleSing();
        return;
      }

      if (_firstInput.isNotEmpty && _operand.isEmpty && value != Btns.equal) {
        _operand += value;
      }
    }
    if (_firstInput.isEmpty || _operand.isEmpty) {
      if (value == Btns.dot && _firstInput.contains(Btns.dot)) return;

      if (int.tryParse(value) != null || value == Btns.dot) {
        if (value == Btns.dot &&
            (_firstInput.isEmpty || _firstInput == Btns.n0)) {
          _firstInput = '0.';
        } else {
          _firstInput += value;
        }
      }
    }
    if (_firstInput.isNotEmpty && _operand.isNotEmpty) {
      if (value == Btns.dot && secondInput.contains(Btns.dot)) return;

      if (int.tryParse(value) != null || value == Btns.dot) {
        if (value == Btns.dot &&
            (_secondInput.isEmpty || _secondInput == Btns.n0)) {
          _secondInput = '0.';
        } else {
          _secondInput += value;
        }
      }
    }
    notifyListeners();
  }

  void clearAll() {
    _firstInput = '';
    _operand = '';
    _secondInput = '';
    notifyListeners();
  }
}
