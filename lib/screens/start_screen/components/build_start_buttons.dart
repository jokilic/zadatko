import 'package:flutter/material.dart';

import '../../../components/zadatko_button.dart';
import '../../../constants/start_screen.dart';

// Create buttons used in the StartScreen
Widget buildStartButtons({
  required BuildContext context,
  required Function loginOnTap,
  required Function signupOnTap,
}) {
  return Container(
    child: Column(
      children: [
        SizedBox(height: 24.0),
        ZadatkoButton(
          text: loginString.toUpperCase(),
          onTap: loginOnTap,
        ),
        SizedBox(height: 32.0),
        ZadatkoButton(
          text: signupString.toUpperCase(),
          onTap: signupOnTap,
        ),
      ],
    ),
  );
}
