import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants/colors.dart';
import './hero_section.dart';
import './illustration.dart';

// Should be some fancy spinner
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        HeroSection(),
        SizedBox(height: 36.0),
        Illustration(''),
        Text(
          'Please wait one moment.',
          style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 30.0),
        ),
        SizedBox(height: 24.0),
        SpinKitFadingCircle(
          color: lightColor,
          size: 36.0,
        ),
      ],
    );
  }
}
