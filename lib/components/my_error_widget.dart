import 'package:flutter/material.dart';

class MyErrorWidget extends StatelessWidget {
  final String errorText;

  MyErrorWidget(this.errorText);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorText,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 28.0),
      ),
    );
  }
}
