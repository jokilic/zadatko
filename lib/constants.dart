import 'package:flutter/material.dart';

import './models/tag.dart';

const String appName = 'Zadatko';

// Tags
List<Tag> tags = [
  Tag(
    color: bluishColor,
    title: 'All tasks',
  ),
  Tag(
    color: Colors.indigo[300],
    title: 'Work',
  ),
  Tag(
    color: Colors.green[300],
    title: 'School',
  ),
  Tag(
    color: Colors.amber[300],
    title: 'Gym',
  ),
  Tag(
    color: Colors.pink[300],
    title: 'Shopping',
  ),
  Tag(
    color: Colors.purple[300],
    title: 'Other',
  ),
];

// Colors
const Color lightColor = Color(0xFFFAFAFA);
const Color darkColor = Color(0xFF212430);
const Color blackColor = Color(0xFF17171A);
const Color blueColor = Color(0xFF5222D0);
const Color redColor = Color(0xFFEC615B);
const Color yellowColor = Color(0xFFCA994D);
const Color bluishColor = Color(0xFF6276CA);

// Fonts
const String avenir = 'Avenir';
const String playfair = 'Playfair Display';

// Icons
const String addIcon = 'assets/icons/add.svg';
const String checkboxCheckedIcon = 'assets/icons/checkbox_checked.svg';
const String checkboxUncheckedIcon = 'assets/icons/checkbox_unchecked.svg';

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

// Error Strings
const String loginUserNotFoundString = 'Usero not foundo.';
const String loginWrongPasswordString = 'Passwordo is wrongo.';
const String signupAccountExistsString = 'Accounto already existando.';
const String signupWeakPasswordString = 'Passwordo not strongo enough.';
const String signupGeneralErrorString = 'Accounto already existando.';
const String generalErrorString = 'Erroro has happendo.';
const String wrongEmailString = 'Emailo no correcto.';

// Start Screen
const String welcomeString = 'Welcome to';
const String loginString = 'Login';
const String signupString = 'Signup';
const String emailHintText = 'E-Mail';
const String passwordHintText = 'Password';
const String loginTitle = 'Login with existing credentials';
const String signupTitle = 'Create a new account below';
const String bottomTextFirstString = 'You can ';
const String bottomTextSecondString = ' instead.';

// Tasks Screen
const String connectedString = 'You are logindo!\n\n🥳';
const String errorString = 'Erroro has happendo!\n\n🥺';

// Main.dart
ThemeData theme() {
  return ThemeData(
    primaryColor: darkColor,
    accentColor: lightColor,
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
