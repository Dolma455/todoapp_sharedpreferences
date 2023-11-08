import 'package:flutter/material.dart';
import 'package:todo_shared_preferences/todo_app/screen/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        fontFamily: "Poppins",
      ),
      home: const FruitsPage(),
    );
  }
}
