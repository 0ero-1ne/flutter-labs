import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sabertooth_donut/repository/todo_model.dart';
import 'package:sabertooth_donut/repository/todo_repository.dart';

class FirestorePage extends StatelessWidget {
  const FirestorePage({ super.key });

  @override
  Widget build(BuildContext context) {
    final date = Timestamp.fromDate(DateTime.now());
    final todoRepo = Get.put(TodoRepository());
    const task = 'ggg';

    final todo = TodoModel(task: task, date: date);

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              child: const Text(
                'Save new todo',
                style: TextStyle(fontSize: 24, color: Colors.lightBlue),
              ),
              onTap: () async {
                await todoRepo.createTodo(todo);
              },
            )
          ],
        ),
      ),
    );
  }
}