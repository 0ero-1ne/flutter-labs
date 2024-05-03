import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sabertooth_donut/repository/todo_model.dart';

import 'todo.mocks.dart';

void main() {
  Timestamp? timestamp = Timestamp.fromDate(DateTime.now());
  const task = "Test";

  late MockTodoModel todo;
  late TodoModel model;

  setUp(() {
    model = TodoModel(task: task, date: timestamp);
    todo = MockTodoModel();
    todo.date = timestamp;
    todo.task = task;
  });

  group("TodoModel", () {
    test("Check toStringJson behaviour", () {
      when(todo.toStringJson()).thenReturn("Meow");
      todo.toStringJson();
      verify(todo.toStringJson());
    });

    test("Check return value is not empty", () {
      var result = model.toStringJson();
      expect(result.isNotEmpty, true);
    });

    test("toStringJson() returned value is invalid", () {
      var result = model.toStringJson();
      expect(result, "Lol");
    });

    test("toStringJson() returned value is valid", () {
      var result = model.toStringJson();
      expect(result, "{date: ${timestamp.toString()}, task: $task}");
    });
  });
}