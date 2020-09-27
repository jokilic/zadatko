import 'package:flutter/material.dart';

import '../constants.dart';

// TODO: Make the ErrorScreen nicer looking
class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorString,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }
}
