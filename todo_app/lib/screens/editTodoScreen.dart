//Screen used to edit tasks

import 'package:flutter/material.dart';
import 'package:todo_app/models/todoItem.dart';

class EditTodoScreen extends StatefulWidget {
  final TodoItem todo;
  final BuildContext context;

  EditTodoScreen(this.todo, this.context);

  @override
  _EditTodoScreenState createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  TextEditingController _editingController;

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController(text: widget.todo.getBody());
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  Widget _editTitleTextField() {
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      onSubmitted: (newValue) {
        setState(() {
          widget.todo.editBody(newValue);
          Navigator.pop(widget.context, true);
        });
      },
      decoration:
          new InputDecoration(contentPadding: const EdgeInsets.all(16.0)),
      autofocus: true,
      controller: _editingController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Task"),
      ),
      body: Container(
        child: _editTitleTextField(),
      ),
    );
  }
}
