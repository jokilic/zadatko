import 'package:flutter/material.dart';

import '../constants/general.dart';
import '../constants/start_screen.dart';

// The title on the top of the StartScreen
class HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          welcomeString,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 28.0),
        ),
        Text(
          appName,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline1,
        ),
      ],
    );
  }
}
