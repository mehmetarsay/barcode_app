import 'package:flutter/material.dart';

class DColors {
  DColors._();
  static const grey0 = Color(0xFFF9F9F9);
  static const grey1 = Color(0xFFDADEE3);
  static const grey2 = Color(0xFFBDBDBD);
  static const grey3 = Color(0xFF797979);
  static const grey4 = Color(0xFF717171);
  static const barrier = Color(0x609E9E9E);
  static const barrierGrey = Color(0x99000000);
  static const dark = Color(0xFF303030);
  static const darkPrimary = Color.fromRGBO(4, 4, 4, 2);
  static const primary = Color.fromARGB(255, 26, 0, 176);
  static const secondary = Color.fromARGB(255, 105, 141, 151);
}

@immutable
class Color2 {
  final Color first;
  final Color second;
  static const grey1 = Color2(first: DColors.grey1);
  static const primary = Color2(first: DColors.primary, second: DColors.dark);
  static const navigate = Color2(first: Colors.white, second: DColors.dark);

  const Color2({Color? first, Color? second})
      : first = first ?? Colors.transparent,
        second = second ?? Colors.transparent;

  Color2 withItem1(Color first) => Color2(first: first, second: second);
}
