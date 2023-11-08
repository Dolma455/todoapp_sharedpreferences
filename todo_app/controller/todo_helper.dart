
import 'package:todo_shared_preferences/todo_app/controller/db_helper.dart';
import 'package:todo_shared_preferences/todo_app/model/todo_model.dart';

class TodoHelper {
  static addTodo(Fruits fruit) async {
    final fruits = await DbHelper.loadItemsFromSharedPreferences();
    fruits.add(
      Fruits(id: fruit.id, fruit: fruit.fruit, description: fruit.description),
    );
    await DbHelper.saveItemsToSharedPreferences(fruits);
  }

  static updateTodo(
    int id,
    String title,
    String desc,
    int index,
  ) async {
    final fruitList = await DbHelper.loadItemsFromSharedPreferences();
    fruitList.replaceRange(
        index, index + 1, [Fruits(id: id, fruit: title, description: desc)]);
    await DbHelper.saveItemsToSharedPreferences(fruitList);
  }

  static deleteTodo(List<Fruits> fruitsData, int index) async {
    fruitsData.removeAt(index);
    await DbHelper.saveItemsToSharedPreferences(fruitsData);
  }
}
