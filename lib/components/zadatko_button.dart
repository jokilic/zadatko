import 'package:flutter/material.dart';

import '../constants/colors.dart';

// Standardized button used across the app
class ZadatkoButton extends StatelessWidget {
  final String text;
  final Function onTap;

  ZadatkoButton({
    @required this.text,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.symmetric(
        horizontal: 36.0,
        vertical: 20.0,
      ),
      child: Text(
        text.toUpperCase(),
        style: Theme.of(context).textTheme.button,
      ),
      onPressed: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(
          color: lightColor,
          width: 3,
        ),
      ),
    );
  }
}
