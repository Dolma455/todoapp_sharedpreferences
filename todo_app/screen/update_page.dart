import 'package:flutter/material.dart';
import 'package:todo_shared_preferences/todo_app/controller/todo_helper.dart';
import 'package:todo_shared_preferences/todo_app/model/todo_model.dart';
import 'package:todo_shared_preferences/todo_app/screen/home_screen.dart';

class UpdateFruit extends StatefulWidget {
  const UpdateFruit({
    super.key,
    required this.fruits,
    required this.index,
  });
  final Fruits fruits;
  final int index;

  @override
  State<UpdateFruit> createState() => _UpdateFruitState();
}

class _UpdateFruitState extends State<UpdateFruit> {
  late String desc;
  late int id;
  TextEditingController textController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textController.text = widget.fruits.description;
    titleController.text = widget.fruits.fruit;
    desc = widget.fruits.description;
    id = UniqueKey().hashCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: titleController,
          decoration: const InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
            color: Colors.white,
          ))),
          cursorColor: Colors.white,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green[400],
        shadowColor: Colors.green[400],
      ),
      body: Column(
        children: [
          TextField(
            controller: textController,
            onChanged: (newDescription) {
              setState(() {
                desc = newDescription;
              });
            },
          ),
          TextButton(
            onPressed: () async {
              TodoHelper.updateTodo(
                id,
                titleController.text,
                desc,
                widget.index,
              );
              if (!mounted) return;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => const FruitsPage(),
                ),
              );
            },
            child: Text(
              "Update".toUpperCase(),
              style: TextStyle(color: Colors.green[400]),
            ),
          ),
        ],
      ),
    );
  }
}
