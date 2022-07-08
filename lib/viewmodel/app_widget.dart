import 'package:flutter/material.dart';
import 'home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter API',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const ListAPI(),
    );
  }
}