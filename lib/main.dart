import 'package:flutter/material.dart';
import 'package:jokes_app/screens/joke_types_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jokes App',
      initialRoute: '/',
      routes: {
        '/' : (context) =>  const HomeScreen(),
      },
    );
  }
}