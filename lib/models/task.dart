import 'package:flutter/material.dart';

import './tag.dart';

class Task extends ChangeNotifier {
  final String text;
  final Tag tag;
  final Color color;
  bool isDone;

  Task({
    this.text,
    this.tag,
    this.color,
    this.isDone = false,
  });
}
