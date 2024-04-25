import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab9/battery_widget.dart';
import 'package:lab9/bloc/battery_bloc.dart';
import 'package:lab9/header.dart';
import 'package:lab9/trip_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ));

    var statusBarHeight = MediaQuery.of(context).viewPadding.top;
    List<String> oneCurator = <String>["man.png"];
    List<String> twoCurators = <String>["man.png", "woman.png"];
    
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(25, statusBarHeight + 10, 25, 25),
            child: Column(
              children: <Widget> [
                const Header(),
                TripCard(climat: "sun", country: "Konoha", period: "Spring 2024 - 14 days", curators: oneCurator),
                TripCard(climat: "leaf", country: "Tokyo", period: "Spring 2024 - 14 days", curators: twoCurators),
                BlocProvider(
                  create: (BuildContext context) => BatteryBloc(),
                  lazy: false,
                  child: const BatteryWidget(),
                ),
              ]
            )
          ),
        ),
      )
    );
  }
}