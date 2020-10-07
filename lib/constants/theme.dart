import 'package:flutter/material.dart';
import './colors.dart';
import './fonts.dart';

///////////////////////
// THEME
///////////////////////

ThemeData theme() {
  return ThemeData(
    primaryColor: darkColor,
    accentColor: lightColor,
    canvasColor: Colors.transparent,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: avenir,
    textTheme: TextTheme(
      headline1: TextStyle(
        color: lightColor,
        fontSize: 50.0,
        fontFamily: playfair,
        fontWeight: FontWeight.w600,
      ),
      bodyText1: TextStyle(
        color: lightColor,
        fontSize: 24.0,
      ),
      button: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
        letterSpacing: 10,
      ),
    ),
  );
}
