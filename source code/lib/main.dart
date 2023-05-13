import 'package:flutter/material.dart';
import 'package:mindtales/screens/on_boarding.dart';

int ? initScreen;

Future<void> main() async {


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mind Tales',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Onbording()
    );
  }
}