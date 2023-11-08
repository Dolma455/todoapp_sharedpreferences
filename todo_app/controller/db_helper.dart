import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_shared_preferences/todo_app/model/todo_model.dart';

class DbHelper {
  static Future<void> saveItemsToSharedPreferences(List<Fruits> data) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> fruitsData =
        data.map((fruit) => jsonEncode(fruit.toMap())).toList();
    await prefs.setStringList('ffruits', fruitsData);
  }

  static Future<List<Fruits>> loadItemsFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> fruitsData = prefs.getStringList('ffruits') ?? [];
    final ffruits = fruitsData
        .map((fruitData) => Fruits.fromMap(jsonDecode(fruitData)))
        .toList();
    return ffruits;
  }
}
