import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab4_5/header.dart';
import 'package:lab4_5/trip_card.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({ super.key });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _platform = const MethodChannel('samples.flutter.dev/battery');
  String _batteryLevel = 'Tap to update battery level info';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.white,
    ));

    var statusBarHeight = MediaQuery.of(context).viewPadding.top;
    List<String> oneCurator = <String>["man.png"];
    List<String> twoCurators = <String>["man.png", "woman.png"];
    
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(bottom: 25, top: statusBarHeight + 25),
              padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
              color: Colors.white,
              child: Column(
                children: <Widget> [
                  const Header(),
                  TripCard(climat: "sun", country: "Konoha", period: "Spring 2024 - 14 days", curators: oneCurator),
                  TripCard(climat: "leaf", country: "Tokyo", period: "Spring 2024 - 14 days", curators: twoCurators),
                  InkWell(
                    onTap: _getBatteryLevel,
                    child: Text(_batteryLevel),
                  )
                ]
              )
            ),
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(bottom: 25, top: statusBarHeight + 25),
              padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
              color: Colors.white,
              child: Column(
                children: <Widget> [
                  const Header(),
                  TripCard(climat: "snow", country: "Canada", period: "Spring 2024 - 14 days", curators: twoCurators),
                  TripCard(climat: "leaf", country: "Belgium", period: "Summer 2024 - 14 days", curators: oneCurator),
                ]
              )
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final result = await _platform.invokeMethod<int>('getBatteryLevel');
      batteryLevel = 'Battery level: $result %';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'";
    }
    _batteryLevel = batteryLevel;
    
    setState(() {
      _batteryLevel = batteryLevel;
    });
  }
}