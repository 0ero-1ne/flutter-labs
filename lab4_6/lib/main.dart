import 'package:flutter/material.dart';
import 'package:lab4_5/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(brightness: Brightness.light)
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}