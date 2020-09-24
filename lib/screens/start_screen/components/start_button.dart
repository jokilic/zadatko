import 'package:flutter/material.dart';

class StartButton extends StatelessWidget {
  final String text;
  final Function onTap;
  final Color color;

  StartButton({
    @required this.text,
    @required this.onTap,
    @required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.symmetric(
        horizontal: 28.0,
        vertical: 16.0,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.button,
      ),
      onPressed: onTap,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}
