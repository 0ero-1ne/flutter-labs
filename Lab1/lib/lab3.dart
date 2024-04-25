import 'package:lab1/bread.dart';
import 'package:lab1/store.dart';
import 'package:lab1/collection.dart';
import 'package:logger/logger.dart';
import 'dart:convert';
import 'dart:async';

Logger logger = Logger();

void printInfo() {
    logger.d("Changed");
}

Future<void> doWork() async {
  logger.d("Starting async...");
  String message = await getMessage();
  logger.d("Message: $message");
  logger.d("Endind async...");
}

Future<String> getMessage() {
  return Future.delayed(const Duration(seconds: 1), () => "Hello, Dart");
}

void main() {
    try {
        doWork();
        Bread breadOne = Bread.food('Black bread', 350);
        Bread breadTwo = Bread.food('White bread', 450);
        List<Bread> list = [];
        list.add(breadOne);
        list.add(breadTwo);
        Store store = Store(list);

        Stream<int> stream = Stream<int>.fromIterable([1, 2, 3, 4, 5]);
        Stream<int> broadcastStream = Stream<int>.fromIterable([1, 2, 3, 4, 5]).asBroadcastStream();

        stream.listen((data) {
          logger.d("Single broadcast: $data");
        }, onDone: () {
          logger.d("Single broadcast done");
        }, onError: (error) {
          logger.d("Error: $error");
        });

        broadcastStream.listen((data) {
            logger.d('Listener 1: $data');
        });

        broadcastStream.listen((data) {
            logger.d('Listener 2: $data');
        });

        broadcastStream.listen(null, onDone: () {
            logger.d('BroadcastStream is done');
        });

        logger.d(breadOne.creationDate);
        logger.d(breadOne.compareTo(breadTwo));

        while (store.moveNext()) {
          logger.d(store.current);
        }

        Iterable<Bread> breads = [breadOne, breadTwo];
        logger.d("Iterable");
        logger.d(breads.elementAt(0));

        String jsonString = jsonEncode(breadOne);
        logger.d(jsonString);

        Collection breadsCollection = Collection();
        breadsCollection.add(breadOne);
        breadsCollection.add(breadTwo);
      }
    catch(e) {
        logger.d("Exception $e");
    }
}