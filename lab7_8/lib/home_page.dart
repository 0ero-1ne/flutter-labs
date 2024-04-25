import 'dart:io';
import 'dart:async';

import 'package:lab7_8/bread.dart';
import 'package:lab7_8/database/bread_db.dart';
import 'package:lab7_8/orm_hive.dart';
import 'package:lab7_8/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:lab7_8/input_form.dart';
import 'package:path_provider/path_provider.dart';
import 'package:lab7_8/database/database_service.dart';

const List<String> directories = [
  'TemporaryDirectory',
  'ApplicationDocumentsDirectory',
  'ApplicationSupportDirectory',
  'ExternalStorageDirectory',
  'ExternalCacheDirectories'
];

String? dropdownValue;
final directoryState = ValueNotifier<Directory?>(null);
DatabaseService databaseService = DatabaseService();

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(25),
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 50),
                      child: const Text(
                        "Sqflite",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none
                        ),
                      ),
                    ),
                    const DropdownButtonExample(),
                    Container(
                      height: 500,
                      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                      child: const BreadsList(),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: FloatingActionButton(
                        onPressed: () async {
                          Database? db = await databaseService.database;
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => InputForm(bread: null, db: db))
                          ).then((value) async {
                            if (value == true) {
                              setDirectoryState();
                            }
                          });
                        },
                        child: const Icon(Icons.add),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(25),
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 50),
                    child: const Text(
                      "Shared preferences",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none
                      ),
                    ),
                  ),
                  SharedPreferencesWidget()
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(25),
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 50),
                    child: const Text(
                      "ORM Hive",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none
                      ),
                    ),
                  ),
                  OrmHiveWidget()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      icon: const Icon(Icons.arrow_downward),
      hint: const Text('Select directory'),
      onChanged: (String? value) async {
        setState(() {
          dropdownValue = value!;
        });
        await setDirectoryState();
      },
      items: directories.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList()
    );
  }
}

class BreadsList extends StatefulWidget {
  const BreadsList({super.key});

  @override
  State<BreadsList> createState() => _BreadsListState();
}

class _BreadsListState extends State<BreadsList> {
  Future<List<Bread>> fetchData() async {
    Database? db = await databaseService.database;
    return await BreadDB.fetchAll(db!);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder (
      valueListenable: directoryState,
      builder: (context, value, child) {
        return FutureBuilder<List<Bread>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              final breads = snapshot.data;
              if (breads == null || breads.isEmpty) {
                return const Text(
                  'No records',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold
                  ),
                );
              } else {
                return ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemCount: breads.length,
                  itemBuilder: (context, index) {
                    final bread = breads[index];
                    final subtitle = bread.calories;

                    return ListTile(
                      title: Text(
                        bread.title,
                        style: const TextStyle(fontWeight: FontWeight.bold)
                      ),
                      subtitle: Text(subtitle.toString()),
                      trailing: IconButton(
                        onPressed: () async {
                          Database? db = await databaseService.database;
                          await BreadDB.delete(database: db!, id: bread.id);
                          await setDirectoryState();
                        },
                        icon: const Icon(Icons.delete, color: Colors.red)
                      ),
                      onTap: () async {
                        Database? db = await databaseService.database;
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => InputForm(bread: bread, db: db!))
                        ).then((value) async {
                          if (value == true) {
                            await setDirectoryState();
                          }
                        });
                      },
                    );
                  },
                );
              }
            }
          }
        );
      }
    );
  }

  void updateList(){
    var oldDirectory = directoryState.value;
    directoryState.value = null;
    directoryState.value = oldDirectory;
  }
}

Future<void> setDirectoryState() async {
    Directory? directory;
    switch(directories.indexOf(dropdownValue!)) {
      case 0:
        directory = await getTemporaryDirectory();
      case 1:
        directory = await getApplicationDocumentsDirectory();
      case 2:
        directory = await getApplicationSupportDirectory();
      case 3:
        directory = await getExternalStorageDirectory();
      case 4:
        await getExternalCacheDirectories().then((value) => directory = value?.first);
      default:
        break;
    }

    await databaseService.database.then((value) => value?.close());
    await databaseService.setStorage(directory!.path);
    directoryState.value = directory;
  }