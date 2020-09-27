import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants.dart';
import '../../models/auth.dart';
import './components/start_fields.dart';
import './components/build_start_buttons.dart';
import '../../components/hero_section.dart';

enum StartFieldsState {
  start,
  login,
  signup,
}

StartFieldsState startFieldsState = StartFieldsState.start;
String loginErrorText = '';
String signupErrorText = '';

class StartScreen extends StatefulWidget {
  static const routeName = '/start-screen';

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Get an illustration to show on the StartScreen
  String get getRandomIllustration =>
      illustrations[Random().nextInt(illustrations.length)];

  // Used for Login errors
  void generateLoginErrorText() {
    switch (loginState) {
      case LoginState.userNotFound:
        loginErrorText = loginUserNotFoundString;
        break;
      case LoginState.wrongPassword:
        loginErrorText = loginWrongPasswordString;
        break;
      case LoginState.generalError:
        loginErrorText = generalErrorString;
        break;
      case LoginState.loggedIn:
        loginErrorText = '';
        break;
      default:
        loginErrorText = '';
    }
    setState(() {});
  }

  void generateSignupErrorText() {
    switch (signupState) {
      case SignupState.accountExists:
        signupErrorText = signupAccountExistsString;
        break;
      case SignupState.weakPassword:
        signupErrorText = signupWeakPasswordString;
        break;
      case SignupState.generalError:
        signupErrorText = generalErrorString;
        break;
      case SignupState.signedUp:
        signupErrorText = '';
        break;
      default:
        signupErrorText = '';
    }
    setState(() {});
  }

  // Change the StartFieldsState enum
  void changeStartScreenState(StartFieldsState newStartFieldsState) {
    setState(() {
      startFieldsState = newStartFieldsState;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: darkColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            width: size.width,
            child: Column(
              children: [
                SizedBox(height: 56.0),
                HeroSection(),
                SizedBox(height: 56.0),
                SvgPicture.asset(
                  getRandomIllustration,
                  width: size.width * 0.9,
                ),
                SizedBox(height: 36.0),
                if (startFieldsState == StartFieldsState.start)
                  // Show Login & Signup Buttons
                  buildStartButtons(
                    context: context,
                    loginOnTap: () =>
                        changeStartScreenState(StartFieldsState.login),
                    signupOnTap: () =>
                        changeStartScreenState(StartFieldsState.signup),
                  ),
                if (startFieldsState == StartFieldsState.login)
                  // Show Login fields
                  StartFields(
                    titleText: loginTitle,
                    buttonText: loginString.toUpperCase(),
                    bottomText: signupString,
                    errorText: loginErrorText,
                    emailController: emailController,
                    passwordController: passwordController,
                    buttonCallback: () async {
                      // TODO: Make some Loading indicator while waiting
                      await Auth().loginFirebase(
                        emailController.text,
                        passwordController.text,
                      );
                      generateLoginErrorText();
                    },
                    bottomTextCallback: () =>
                        // TODO: Clear fields & Error text
                        changeStartScreenState(StartFieldsState.signup),
                  ),
                if (startFieldsState == StartFieldsState.signup)
                  // Show Signup Buttons
                  StartFields(
                    titleText: signupTitle,
                    buttonText: signupString.toUpperCase(),
                    bottomText: loginString,
                    errorText: signupErrorText,
                    emailController: emailController,
                    passwordController: passwordController,
                    buttonCallback: () async {
                      // TODO: Make some Loading indicator while waiting
                      await Auth().signupFirebase(
                        emailController.text,
                        passwordController.text,
                      );
                      generateSignupErrorText();
                    },
                    bottomTextCallback: () =>
                        // TODO: Clear fields & Error text
                        changeStartScreenState(StartFieldsState.login),
                  ),
                SizedBox(height: 100.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
