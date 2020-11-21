import './tag.dart';

class Task {
  final String? title;
  final String? description;
  final Tag? tag;
  bool? isDone;

  Task({
    this.title,
    this.description,
    this.tag,
    this.isDone = false,
  });
}
