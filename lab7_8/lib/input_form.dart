import 'package:flutter/material.dart';
import 'package:lab7_8/bread.dart';
import 'package:lab7_8/database/bread_db.dart';
import 'package:sqflite/sqflite.dart';

// ignore: must_be_immutable
class InputForm extends StatelessWidget {
  final Bread? bread;
  final Database? db;
  String? breadTitle;
  double? breadCalories;

  InputForm({super.key, required this.bread, required this.db});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    if (bread != null) {
      breadTitle = bread!.title;
      breadCalories = bread!.calories;
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(25),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FloatingActionButton(
                    child: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                      child: TextFormField(
                        initialValue: breadTitle,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Enter bread name'
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onChanged: (value) => {
                          breadTitle = value.trim().toLowerCase()
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: breadCalories.toString() == "null" ? '' : breadCalories.toString(),
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Enter bread calories'
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onChanged: (value) => {
                          breadCalories = double.tryParse(value.trim().toLowerCase())
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.purple,
                              side: const BorderSide(
                                color: Colors.purple,
                              ),
                            ),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                if (bread == null) {
                                  await BreadDB.create(
                                    database: db!,
                                    title: breadTitle!,
                                    calories: breadCalories!
                                  );
                                } else {
                                  await BreadDB.update(
                                    database: db!,
                                    id: bread!.id,
                                    title: breadTitle!,
                                    calories: breadCalories!
                                  );
                                }
                                Navigator.pop(context, true);
                              }
                            },
                            child: const Text("Save"),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ),
      )
    );
  }
}