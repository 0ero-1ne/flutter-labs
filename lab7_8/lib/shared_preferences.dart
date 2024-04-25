import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class SharedPreferencesWidget extends StatelessWidget {
  SharedPreferences? prefs;
  SharedPreferencesWidget({super.key});
  
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
            prefs = await SharedPreferences.getInstance();
          },
          child: const Text("Load"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
          ),
          onPressed: () async {
            int state = 0;
            if (prefs == null) {
              state = 1;
            }
            int? counter = prefs?.getInt('counter');
            if (counter == null && state != 1) {
              await prefs!.setInt('counter', 1);
              state = 2;
            }

            return showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Shared Preferences'),
                content: Text(
                  state == 1 ? 'Please, load shared preferences' : 'Created'
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
            if (prefs == null) {
              state = 1;
            }
            int? counter = prefs?.getInt('counter');
            if (counter == null && state != 1) {
              state = 2;
            } else if (counter != null && state != 1) {
              state = 3;
            }
            
            return showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Shared Preferences'),
                content: Text(
                  state == 1 ? 'Please, load shared preferences' : state == 2 ? 'Null value' : 'Pref value: $counter'
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
            if (prefs == null) {
              state = 1;
            }
            int? counter = prefs?.getInt('counter');
            if (counter == null && state != 1) {
              state = 2;
            } else if (counter != null && state != 1) {
              await prefs?.remove('counter');
              state = 3;
            }

            return showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Shared Preferences'),
                content: Text(
                  state == 1 ? 'Please, load shared preferences' : state == 2 ? 'Nothing to delete' : 'Value was deleted'
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