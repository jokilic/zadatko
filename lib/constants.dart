import 'package:flutter/material.dart';

const String appName = 'Zadatko';

// Colors
const Color lightColor = Color(0xFFFAFAFA);
const Color darkColor = Color(0xFF212430);
const Color blueColor = Color(0xFF5222D0);
const Color redColor = Color(0xFFEC615B);

// Fonts
const String avenir = 'Avenir';
const String playfair = 'Playfair Display';

// Illustrations
const String ideaIllustration = 'assets/illustrations/idea.svg';
const String joggingIllustration = 'assets/illustrations/jogging.svg';
const String learningIllustration = 'assets/illustrations/learning.svg';
const String planIllustration = 'assets/illustrations/plan.svg';
const String visionIllustration = 'assets/illustrations/vision.svg';
const String welcomeIllustration = 'assets/illustrations/welcome.svg';
const String yogaIllustration = 'assets/illustrations/yoga.svg';

const List<String> illustrations = [
  ideaIllustration,
  joggingIllustration,
  learningIllustration,
  planIllustration,
  visionIllustration,
  welcomeIllustration,
  yogaIllustration,
];

// Start Screen
const String welcomeString = 'Welcome to';
const String loginString = 'Login';
const String signupString = 'Signup';
const String emailHintText = 'E-Mail';
const String passwordHintText = 'Password';

// Main.dart
ThemeData theme() {
  return ThemeData(
    primaryColor: darkColor,
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
        color: lightColor,
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
        letterSpacing: 10,
      ),
    ),
  );
}
