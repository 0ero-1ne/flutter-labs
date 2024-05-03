// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sabertooth_donut/bloc/auth_bloc.dart';
import 'package:sabertooth_donut/pages/auth/register.dart';
import 'package:sabertooth_donut/pages/home.dart';

typedef Callback = void Function(MethodCall call);

class MockTask extends Mock {
  void call();
}

Future<T> neverEndingFuture<T>() async {
  while (true) {
    await Future.delayed(const Duration(minutes: 5));
  }
}

void main() {
  testWidgets('Test text insertion', (WidgetTester tester) async {
    final loginField = find.byKey(const ValueKey("email"));
    final passwordField = find.byKey(const ValueKey("password"));
    //final loginButton = find.byKey(const ValueKey("register_button"));

    await tester.pumpWidget(
      MaterialApp(home: BlocProvider<AuthBloc>(
        create:(context) => AuthBloc(null),
        lazy: false,
        child: Scaffold(
          body: RegisterPage(),
        ),
      ))
    );

    await tester.enterText(loginField, "vil.bil@mail.ff");
    await tester.enterText(passwordField, "123456");

    await tester.idle();
    await tester.pump();

    expect(find.textContaining('vil.bil@mail.ff'), findsOneWidget);
    expect(find.textContaining('123456'), findsOneWidget);
  });

  testWidgets('Test tap', (WidgetTester tester) async {
    final tap = find.byKey(const ValueKey("tap"));

    await tester.pumpWidget(
      MaterialApp(home: BlocProvider<AuthBloc>(
        create:(context) => AuthBloc(null),
        lazy: false,
        child: const Scaffold(
          body: HomePage(),
        ),
      ))
    );

    await tester.tap(tap);

    await tester.idle();
    await tester.pump();
  
    expect(find.text('Tapped'), findsOneWidget);
  });

  testWidgets('Drag test', (WidgetTester tester) async {
    final draggable = find.byKey(const ValueKey("draggable"));

    await tester.pumpWidget(
      MaterialApp(home: BlocProvider<AuthBloc>(
        create:(context) => AuthBloc(null),
        lazy: false,
        child: const Scaffold(
          body: HomePage(),
        ),
      ))
    );

    await tester.drag(draggable, const Offset(0, 50));
    await tester.idle();
    await tester.pump();

    expect(find.text('Dragged'), findsOneWidget);
  });
}