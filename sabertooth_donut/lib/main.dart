import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:logger/logger.dart';
import 'package:sabertooth_donut/bloc/auth_bloc.dart';

import 'package:sabertooth_donut/pages/home.dart';
import 'package:sabertooth_donut/pages/firestore_page.dart';
import 'package:sabertooth_donut/pages/profile.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  await FirebaseMessaging.instance.requestPermission();
  final fCMToken = await FirebaseMessaging.instance.getToken();
  Logger().d("Token: $fCMToken");

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  User? _user;
  int _pageIndex = 0;

  _MyApp() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) => _user = user);
  }

  @override
  Widget build(BuildContext context) {
    var pages = [
      const HomePage(),
      const FirestorePage(),
      const ProfilePage()
    ];

    return BlocProvider(
      create: (context) => AuthBloc(_user),
      lazy: false,
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: pages[_pageIndex],
          bottomNavigationBar: NavigationBarTheme(
            data: const NavigationBarThemeData(),
            child: NavigationBar(
              selectedIndex: _pageIndex,
              onDestinationSelected: (index) => setState(() => _pageIndex = index),
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Home'
                ),
                NavigationDestination(
                  icon: Icon(Icons.chat_outlined),
                  selectedIcon: Icon(Icons.chat),
                  label: 'Firestore'
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outline),
                  selectedIcon: Icon(Icons.person),
                  label: 'Me',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}