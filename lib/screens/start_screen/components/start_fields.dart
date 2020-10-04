import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/start_screen.dart';
import '../../../components/zadatko_text_field.dart';
import '../../../components/zadatko_button.dart';

// Create TextFields & other elements used in the StartScreen
class StartFields extends StatelessWidget {
  final String titleText;
  final String buttonText;
  final String bottomText;
  final String errorText;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function buttonCallback;
  final Function bottomTextCallback;
  final bool isLoading;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final Function emailOnEditingComplete;
  final Function passwordOnEditingComplete;

  StartFields({
    @required this.titleText,
    @required this.buttonText,
    @required this.bottomText,
    @required this.emailController,
    @required this.passwordController,
    @required this.buttonCallback,
    @required this.bottomTextCallback,
    @required this.errorText,
    this.isLoading = false,
    @required this.emailFocusNode,
    @required this.passwordFocusNode,
    @required this.emailOnEditingComplete,
    @required this.passwordOnEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 36.0),
      child: Column(
        children: [
          Text(
            titleText,
            textAlign: TextAlign.center,
            style:
                Theme.of(context).textTheme.headline1.copyWith(fontSize: 24.0),
          ),
          SizedBox(height: 24.0),
          ZadatkoTextField(
            hintText: emailHintText,
            focusNode: emailFocusNode,
            onEditingComplete: emailOnEditingComplete,
            textEditingController: emailController,
          ),
          SizedBox(height: 24.0),
          ZadatkoTextField(
            hintText: passwordHintText,
            focusNode: passwordFocusNode,
            onEditingComplete: passwordOnEditingComplete,
            isObscureText: true,
            textEditingController: passwordController,
          ),
          SizedBox(height: 20.0),
          Text(
            errorText,
            textAlign: TextAlign.center,
            style:
                Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 20.0),
          ),
          SizedBox(height: 20.0),
          isLoading
              ? CircularProgressIndicator(backgroundColor: darkColor)
              : Column(
                  children: [
                    ZadatkoButton(
                      text: buttonText,
                      onTap: buttonCallback,
                    ),
                    SizedBox(height: 12.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          bottomTextFirstString,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(fontSize: 18.0),
                        ),
                        GestureDetector(
                          onTap: bottomTextCallback,
                          child: Text(
                            bottomText,
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                          ),
                        ),
                        Text(
                          bottomTextSecondString,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(fontSize: 18.0),
                        ),
                      ],
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
