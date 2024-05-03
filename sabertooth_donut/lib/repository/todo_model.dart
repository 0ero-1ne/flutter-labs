import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String? task;
  Timestamp? date;

  TodoModel({
    required this.task,
    required this.date
  });

  Map<String, Object?> toJson() {
    return {
      "date": date,
      "task": task
    };
  }

  String toStringJson() {
    return "{date: ${date.toString()}, task: $task}";
  }
}