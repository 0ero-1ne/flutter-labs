import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:path_provider/path_provider.dart';

// ignore: must_be_immutable
class OrmHiveWidget extends StatelessWidget {
  dynamic box;
  
  OrmHiveWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
          ),
          onPressed: () async {
            var directory = await getApplicationDocumentsDirectory();
            box = await Hive.openBox<int>('myBox', path: directory.path);
          },
          child: const Text("Load"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
          ),
          onPressed: () async {
            int state = 0;
            int? counter = await box.get('counter');

            if (counter == null) {
              await box.put('counter', 1);
              state = 1;
            }

            return showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Shared Preferences'),
                content: Text(
                  state == 0 ? 'Already exists' : 'Created'
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              )
            );
          },
          child: const Text("Create"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
          ),
          onPressed: () async {
            int state = 0;
            int? counter = await box.get('counter');

            if (counter == null) {
              state = 1;
            } else {
              state = 2;
            }
            
            return showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Shared Preferences'),
                content: Text(
                  state == 1 ? 'Nothing to read' : 'Counter value: $counter'
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              )
            );
          },
          child: const Text("Read"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
          ),
          onPressed: () async {
            int state = 0;

            int? counter = await box.get('counter');
            if (counter == null) {
              state = 1;
            } else {
              await box.delete('counter');
              state = 2;
            }

            return showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Shared Preferences'),
                content: Text(
                  state == 1 ? 'Nothing to delete' : 'Deleted'
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              )
            );
          },
          child: const Text("Delete"),
        ),
      ],
    );
  }
}