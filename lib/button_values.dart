import 'package:flutter/material.dart';

enum ButtonArea1 {
  n7,
  n8,
  n9,
  clr,
  priority,
  n4,
  n5,
  n6,
  add,
  subtract,
  n1,
  n2,
  n3,
  multiply,
  divide,
  dot,
  n0,
  notation,
  calculate,
  per,
  operations,
}

final keyboardButtonsLandscape = [
  ButtonArea1.n7,
  ButtonArea1.n8,
  ButtonArea1.n9,
  ButtonArea1.clr,
  ButtonArea1.priority,
  ButtonArea1.n4,
  ButtonArea1.n5,
  ButtonArea1.n6,
  ButtonArea1.add,
  ButtonArea1.multiply,
  ButtonArea1.n1,
  ButtonArea1.n2,
  ButtonArea1.n3,
  ButtonArea1.subtract,
  ButtonArea1.divide,
  ButtonArea1.dot,
  ButtonArea1.n0,
  ButtonArea1.notation,
  ButtonArea1.calculate,
  ButtonArea1.per,
];

final keyboardButtonsPortrait = [
  ButtonArea1.clr,
  ButtonArea1.priority,
  ButtonArea1.per,
  ButtonArea1.divide,
  ButtonArea1.n7,
  ButtonArea1.n8,
  ButtonArea1.n9,
  ButtonArea1.multiply,
  ButtonArea1.n4,
  ButtonArea1.n5,
  ButtonArea1.n6,
  ButtonArea1.subtract,
  ButtonArea1.n1,
  ButtonArea1.n2,
  ButtonArea1.n3,
  ButtonArea1.add,
  ButtonArea1.dot,
  ButtonArea1.n0,
  ButtonArea1.notation,
  ButtonArea1.calculate,
];

final keyboardButtonsReduced = [
  ButtonArea1.n7,
  ButtonArea1.n8,
  ButtonArea1.n9,
  ButtonArea1.clr,
  ButtonArea1.n4,
  ButtonArea1.n5,
  ButtonArea1.n6,
  ButtonArea1.add,
  ButtonArea1.n1,
  ButtonArea1.n2,
  ButtonArea1.n3,
  ButtonArea1.subtract,
  ButtonArea1.dot,
  ButtonArea1.n0,
  ButtonArea1.calculate,
  ButtonArea1.operations,
];

final keyboardButtonsExtended = [
  ButtonArea1.n7,
  ButtonArea1.n8,
  ButtonArea1.n9,
  ButtonArea1.clr,
  ButtonArea1.priority,
  ButtonArea1.n4,
  ButtonArea1.n5,
  ButtonArea1.n6,
  ButtonArea1.add,
  ButtonArea1.multiply,
  ButtonArea1.n1,
  ButtonArea1.n2,
  ButtonArea1.n3,
  ButtonArea1.subtract,
  ButtonArea1.divide,
  ButtonArea1.dot,
  ButtonArea1.n0,
  ButtonArea1.calculate,
  ButtonArea1.operations,
  ButtonArea1.per,
];

extension Lay1Prop on ButtonArea1 {
  Color get color {
    switch (this) {
      case ButtonArea1.clr:
      case ButtonArea1.priority:
      case ButtonArea1.per:
        return const Color(0XFFF6A389).withValues(alpha: 0.78);
      case ButtonArea1.divide:
      case ButtonArea1.multiply:
      case ButtonArea1.subtract:
      case ButtonArea1.add:
        return const Color(0XFFCB935F).withValues(alpha: 0.83);
      case ButtonArea1.calculate:
        return const Color(0XFFFCBB3D).withValues(alpha: 0.58);
      case ButtonArea1.dot:
      case ButtonArea1.notation:
        return const Color(0XFFF4DFC8); // Add color for dot and notation cases

      default:
        return const Color(0XFFF4DFC8);
    }
  }

  Color get textColor {
    switch (this) {
      case ButtonArea1.clr:
        return const Color(0XFFFF0000);
      case ButtonArea1.divide:
      case ButtonArea1.multiply:
      case ButtonArea1.subtract:
      case ButtonArea1.add:
        return const Color(0XFF000000);
      case ButtonArea1.operations:
        return const Color(0XFF3275A8);
      default:
        return const Color(0XFF000000);
    }
  }

  String get text {
    switch (this) {
      case ButtonArea1.clr:
        return "C";
      case ButtonArea1.priority:
        return "()";
      case ButtonArea1.per:
        return '%';
      case ButtonArea1.divide:
        return "÷";
      case ButtonArea1.multiply:
        return "×";
      case ButtonArea1.add:
        return "+";
      case ButtonArea1.subtract:
        return '-';
      case ButtonArea1.calculate:
        return '=';
      case ButtonArea1.dot:
        return ".";
      case ButtonArea1.notation:
        return "+/-";
      case ButtonArea1.n0:
        return "0";
      case ButtonArea1.n1:
        return "1";
      case ButtonArea1.n2:
        return "2";
      case ButtonArea1.n3:
        return "3";
      case ButtonArea1.n4:
        return "4";
      case ButtonArea1.n5:
        return "5";
      case ButtonArea1.n6:
        return "6";
      case ButtonArea1.n7:
        return "7";
      case ButtonArea1.n8:
        return "8";
      case ButtonArea1.n9:
        return "9";
      case ButtonArea1.operations:
        return "Fn";
    }
  }
}
