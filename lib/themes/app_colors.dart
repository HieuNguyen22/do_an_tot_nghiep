import 'package:flutter/material.dart';

final Color disableColor = Color(0xff808080);


class CustomColors {
  static Color get greyTextColor => neutral[200]!;
  static Color get yellowTextColor => yellow;
  static Color get blueButton => blue[900]!;
  static Color get greyButton => neutral[250]!;

  static List<Color> listBlue = [Color(0xFF1F8DD7), Color(0xFF396196)];
  static List<Color> listRed = [Colors.redAccent, Colors.red];

  static const MaterialColor neutral = MaterialColor(
    _neutralPrimaryValue,
    <int, Color>{
      50:  Color(0xFFD1D1D1),
      100: Color(0xFFBFBFBF),
      200: Color(0xFF808080),
      250: Color(0xFFA6A6A6),
      300: Color(0xFFDBEEF4),
      400: Color(0xFFF1F1F1),
      500: Color(_neutralPrimaryValue),
      600: Color(0xFFD7DAD6)
    },
  );
  static const int _neutralPrimaryValue = 0xFF2196F3;

  static const MaterialColor blue = MaterialColor(
    _bluePrimaryValue,
    <int, Color>{
      250: Color(0x402A8ED7),
      540: Color(0x8A2A8ED7),
      900: Color(0xFF3392DC),
      1000: Color(_bluePrimaryValue),
    },
  );
  static const int _bluePrimaryValue = 0xFF2A8ED7;

  static const MaterialColor green = MaterialColor(
    _greenPrimaryValue,
    <int, Color>{
      1000: Color(_greenPrimaryValue),
    },
  );
  static const int _greenPrimaryValue = 0xFF31859C;

  static const MaterialColor yellow = MaterialColor(
    _yellowPrimaryValue,
    <int, Color>{
      380: Color(0x61FEC100),
      1000: Color(_yellowPrimaryValue),
    },
  );
  static const int _yellowPrimaryValue = 0xFFFEC100;

  static const MaterialColor red = MaterialColor(
    _redPrimaryValue,
    <int, Color>{
      380: Color(0x45FF0000),
      1000: Color(_redPrimaryValue),
    },
  );
  static const int _redPrimaryValue = 0xFFFF0000;
}
