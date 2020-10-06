import 'package:flutter/material.dart';

import '../../constants/colors.dart';

// Shows various information about the app, way to use it and the developer
class InfoScreen extends StatelessWidget {
  static const routeName = '/info-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkColor,
      body: SafeArea(
        child: Center(
          child: Text(
            'Hello!\n\n😋',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
      ),
    );
  }
}
