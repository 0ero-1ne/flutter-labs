import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({ super.key });

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  String inkWellText = "Text";
  Color acceptedColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            key: const Key('tap'),
            onTap: () => setState(() => inkWellText = 'Tapped'),
            child: Text(inkWellText),
          ),
          Draggable(
            key: const Key('draggable'),
            data: Colors.red,
            feedback: Container(
              width: 100,
              height: 100,
              color: Colors.grey.withOpacity(0.5),
              child: const Center(child: Text(
                "Data",
                style: TextStyle(
                  fontSize: 16,
                  decoration: TextDecoration.none,
                  color: Colors.green
                ),
              )),
            ),
            onDraggableCanceled:(velocity, offset) => {},
            child: const Text(
              'Drag me',
              style: TextStyle(
                fontSize: 32,
                color: Colors.blue
              ),
            ),
          ),
          DragTarget(
            key: const Key('drag_target'),
            onAcceptWithDetails: (data) => {
              setState(() {
                acceptedColor = data.data as Color;
                inkWellText = "Dragged";
              })
            },
            builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              return Container(
                width: 200,
                height: 200,
                color: accepted.isEmpty ? Colors.grey : acceptedColor,
                child: const Center(
                  child: Text('Lol'),
                ),
              );
            }
          )
        ],
      ),
    );
  }
}