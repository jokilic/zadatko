import 'package:flutter/cupertino.dart';

class Task extends ChangeNotifier {
  final String text;
  final Color color;
  bool isDone;

  Task({
    this.text,
    this.color,
    this.isDone = false,
  });
}
