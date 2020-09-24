import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zadatko/constants.dart';
import 'package:zadatko/screens/start_screen/components/start_text_field.dart';

import 'components/start_button.dart';

enum StartState {
  start,
  login,
  signup,
}

class StartScreen extends StatefulWidget {
  static const routeName = '/login-screen';

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  StartState startState = StartState.start;

  String get getRandomIllustration =>
      illustrations[Random().nextInt(illustrations.length)];

  void changeStartScreenState(StartState newStartState) {
    setState(() {
      startState = newStartState;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: darkColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: size.width,
            child: Column(
              children: [
                SizedBox(height: 56.0),
                Column(
                  children: [
                    Text(
                      welcomeString,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline1
                          .copyWith(fontSize: 28.0),
                    ),
                    Text(
                      appName,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ],
                ),
                SizedBox(height: 36.0),
                SvgPicture.asset(
                  getRandomIllustration,
                  width: size.width * 0.9,
                ),
                SizedBox(height: 36.0),
                if (startState == StartState.start)
                  buildStartButtons(
                    loginOnTap: () => changeStartScreenState(StartState.login),
                    signupOnTap: () =>
                        changeStartScreenState(StartState.signup),
                  ),
                if (startState == StartState.login) buildLoginFields(context),

                // TODO: Create fields for Signup and make an if statement to show it here.
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoginFields(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 36.0),
      child: Column(
        children: [
          Text(
            'Enter your email & password',
            textAlign: TextAlign.center,
            style:
                Theme.of(context).textTheme.headline1.copyWith(fontSize: 24.0),
          ),
          SizedBox(height: 24.0),
          StartTextField(
            hintText: emailHintText,
            onChanged: (value) => null,
          ),
          SizedBox(height: 24.0),
          StartTextField(
            hintText: passwordHintText,
            isObscureText: true,
            onChanged: (value) => null,
          ),
          SizedBox(height: 100.0),
        ],
      ),
    );
  }

  Widget buildStartButtons(
      {@required Function loginOnTap, @required Function signupOnTap}) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 32.0),
          StartButton(
            text: loginString.toUpperCase(),
            onTap: loginOnTap,
            color: blueColor,
          ),
          SizedBox(height: 32.0),
          StartButton(
            text: signupString.toUpperCase(),
            onTap: signupOnTap,
            color: redColor,
          ),
        ],
      ),
    );
  }
}
