//Screen used to add tasks

import 'package:flutter/material.dart';
import 'package:todo_app/models/todoItem.dart';

class AddTodoScreen extends StatefulWidget {
  final List<TodoItem> todos;
  final BuildContext context;

  AddTodoScreen(this.todos, this.context);

  @override
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  TextEditingController _addingController;

  @override
  void initState() {
    super.initState();
    _addingController = TextEditingController();
  }

  @override
  void dispose() {
    _addingController.dispose();
    super.dispose();
  }

  TodoItem _addTodoItem(String task) {
    if (task.length > 0) {
      widget.todos.add(new TodoItem(task));
    }
  }

  Widget _addTaskTextField() {
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      onSubmitted: (val) {
        setState(() {
          _addTodoItem(val);
          Navigator.pop(widget.context, true);
        });
      },
      decoration:
          new InputDecoration(contentPadding: const EdgeInsets.all(16.0)),
      autofocus: true,
      controller: _addingController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new task"),
      ),
      body: Container(
        child: _addTaskTextField(),
      ),
    );
  }
}
