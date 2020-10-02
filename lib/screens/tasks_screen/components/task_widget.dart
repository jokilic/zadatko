import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class TaskWidget extends StatefulWidget {
  final String title;
  final String description;
  final Color color;

  TaskWidget({
    @required this.title,
    @required this.description,
    @required this.color,
  });

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        setState(() {
          isDone = !isDone;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 10.0,
        ),
        decoration: BoxDecoration(
          color: blackColor,
          borderRadius: BorderRadius.circular(8),
        ),
        width: size.width * 0.85,
        height: size.width * 0.27,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 24.0),
              child: SvgPicture.asset(
                isDone ? checkboxCheckedIcon : checkboxUncheckedIcon,
                width: 30.0,
                color: widget.color,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontSize: 20.0),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    widget.description,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontSize: 16.0,
                          color: lightColor.withOpacity(0.6),
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
