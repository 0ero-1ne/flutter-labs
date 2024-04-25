import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  final String? task;
  final Timestamp? date;

  const TodoModel({
    required this.task,
    required this.date
  });

  toJson() {
    return {
      "date": date,
      "task": task
    };
  }
}