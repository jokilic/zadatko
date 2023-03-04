import 'package:flutter/material.dart';

import '../constants/colors.dart';

// Standardized button used across the app
class ZadatkoButton extends StatelessWidget {
  final String text;
  final Function onTap;
  final Color color;

  ZadatkoButton({
    required this.text,
    required this.onTap,
    this.color = lightColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: 36.0,
          vertical: 20.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
            color: color,
            width: 3,
          ),
        ),
      ),
      child: Text(
        text.toUpperCase(),
        style: Theme.of(context).textTheme.button!.copyWith(color: color),
      ),
      onPressed: onTap as void Function()?,
    );
  }
}
