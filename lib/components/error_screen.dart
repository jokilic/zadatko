import 'package:flutter/material.dart';

// Should be a SnackBar()
class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Erroro has happendo. 🥺',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }
}
