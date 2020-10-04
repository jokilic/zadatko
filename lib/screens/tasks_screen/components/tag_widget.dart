import 'package:flutter/material.dart';

// Widget showing a tag in the TasksScreen
class TagWidget extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Color textColor;
  final Function onTap;

  TagWidget({
    @required this.title,
    @required this.backgroundColor,
    @required this.textColor,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        padding: EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 12.0,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyText1.copyWith(
                fontSize: 18.0,
                color: textColor,
              ),
        ),
      ),
    );
  }
}
