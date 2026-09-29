import 'package:flutter/material.dart';

class AppSpacing {
  AppSpacing._();

  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double xxxl = 32.0;

  static const double screenHorizontalPadding = 20.0;

  static const double cardRadius = 16.0;
  static const double buttonRadius = 12.0;
  static const double inputRadius = 12.0;
  static const double chipRadius = 999.0;

  static const double buttonHeight = 52.0;
  static const double inputHeight = 52.0;

  static const List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Color.fromRGBO(23, 26, 31, 0.06),
      blurRadius: 16,
      offset: Offset(0, 4),
    ),
  ];
}
