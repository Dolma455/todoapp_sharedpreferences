import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_shared_preferences/app/app.dart';
import 'package:todo_shared_preferences/todo_app/screen/items_list.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FruitsProvider(),
      child: const MyApp(),
    ),
  );
}
