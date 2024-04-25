import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'todo_model.dart';


class TodoRepository extends GetxController {
  static TodoRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final logger = Logger();

  createTodo(TodoModel todo) async {
    await _db.collection("todos").add(todo.toJson())
      .whenComplete(() => logger.d('created'))
      // ignore: body_might_complete_normally_catch_error
      .catchError((error, stackTrace) {
        logger.e('failed');
      });
  }
}