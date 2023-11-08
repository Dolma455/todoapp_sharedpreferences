import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_shared_preferences/todo_app/controller/db_helper.dart';
import 'package:todo_shared_preferences/todo_app/controller/todo_helper.dart';
import 'package:todo_shared_preferences/todo_app/model/todo_model.dart';
import 'package:todo_shared_preferences/todo_app/screen/items_list.dart';
import 'package:todo_shared_preferences/todo_app/screen/update_page.dart';

class FruitsPage extends StatefulWidget {
  const FruitsPage({super.key});

  @override
  State<FruitsPage> createState() => _FruitsPageState();
}

class _FruitsPageState extends State<FruitsPage> {
  @override
  void initState() {
    super.initState();
    DbHelper.loadItemsFromSharedPreferences();
  }

  List<Fruits> selectedItems = [];
  List<int> clickedIndex = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.green[400],
        backgroundColor: Colors.green[400],
        title: const Text("Todo List"),
      ),
      body: FutureBuilder(
          future: DbHelper.loadItemsFromSharedPreferences(),
          builder: (ctx, snap) {
            if (snap.hasData) {
              final fruitsData = snap.requireData;
              return fruitsData.isNotEmpty
                  ? Consumer<FruitsProvider>(
                      builder: (ctx, fruitsProvider, child) {
                        return ListView.builder(
                            itemCount: fruitsData.length,
                            itemBuilder: (ctx, index) {
                              var fruit = fruitsData[index];
                              return Hero(
                                tag: 'heroTag$index',
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ctx) => UpdateFruit(
                                                  fruits: fruit,
                                                  index: index,
                                                )));
                                  },
                                  child: Card(
                                    child: ListTile(
                                      title: Text(fruit.fruit),
                                      subtitle: Text(fruit.description),
                                      trailing: IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          TodoHelper.deleteTodo(
                                            fruitsData,
                                            index,
                                          );
                                          setState(() {});
                                        },
                                      ),
                                      leading: Checkbox(
                                          activeColor: Colors.green,
                                          value: clickedIndex.contains(index)
                                              ? true
                                              : false,
                                          onChanged: (bool? value) {
                                            clickedIndex
                                                    .where((element) =>
                                                        element == index)
                                                    .toList()
                                                    .isNotEmpty
                                                ? selectedItems.removeWhere(
                                                    (element) =>
                                                        element.id ==
                                                        fruitsData[index].id)
                                                : selectedItems
                                                    .add(fruitsData[index]);
                                            clickedIndex
                                                    .where((element) =>
                                                        element == index)
                                                    .toList()
                                                    .isNotEmpty
                                                ? clickedIndex.remove(index)
                                                : clickedIndex.add(index);

                                            log(clickedIndex.toString());
                                            log("${selectedItems.length} $selectedItems");
                                            setState(() {});
                                          }),
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                    )
                  : const Text("No Data Found");
            } else {
              return const Text("No data");
            }
          }),
      floatingActionButton:
          Consumer<FruitsProvider>(builder: (ctx, fruitsProvider, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              backgroundColor: Colors.green[400],
              heroTag: 'H002',
              onPressed: () async {
                final data = await DbHelper.loadItemsFromSharedPreferences();
                for (var i = 0; i < selectedItems.length; i++) {
                  data.removeWhere(
                      (element) => element.id == selectedItems[i].id);
                  await DbHelper.saveItemsToSharedPreferences(data);
                }
                selectedItems.clear();

                clickedIndex.clear();
                setState(() {});
              },
              child: const Icon(
                Icons.delete,
              ),
            ),
            const Padding(padding: EdgeInsets.all(16)),
            FloatingActionButton(
              backgroundColor: Colors.green[400],
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      String newFruit = '';
                      String description = '';
                      return AlertDialog(
                        title: const Text("Add Task"),
                        content: SizedBox(
                          height: 200,
                          width: 200,
                          child: Column(
                            children: [
                              TextField(
                                cursorColor: Colors.green,
                                decoration: const InputDecoration(
                                    labelText: "Title",
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Colors.green,
                                    ))),
                                onChanged: (value) {
                                  newFruit = value;
                                },
                              ),
                              TextField(
                                cursorColor: Colors.green,
                                decoration: const InputDecoration(
                                    labelText: "Description",
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Colors.green,
                                    ))),
                                onChanged: (value) {
                                  description = value;
                                },
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              TodoHelper.addTodo(Fruits(
                                  id: UniqueKey().hashCode,
                                  fruit: newFruit,
                                  description: description));
                              setState(() {});
                              if (!mounted) return;
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Add',
                              style: TextStyle(
                                color: Colors.green,
                              ),
                            ),
                          )
                        ],
                      );
                    });
              },
              child: const Icon(
                Icons.add,
              ),
            )
          ],
        );
      }),
    );
  }
}
