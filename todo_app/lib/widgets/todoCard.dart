//Widget that holds a task

import 'package:flutter/material.dart';
import 'package:todo_app/models/todoItem.dart';
import 'package:todo_app/screens/editTodoScreen.dart';

class TodoCard extends StatefulWidget {
  final TodoItem todo;
  final int index;

  const TodoCard(this.todo, this.index);

  @override
  _TodoCardState createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  void crossTodoItem(TodoItem todo) {
    setState(() {
      todo.markAsDone();
    });
  }

  void editTask() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditTodoScreen(widget.todo, context)),
    );
    if (result) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Row(children: <Widget>[
      Expanded(
          child: ListTile(
        leading: widget.todo.symbol(),
        title: new Text(widget.todo.getBody(),
            style: (widget.todo.isDone()
                ? TextStyle(
                    decoration: TextDecoration.lineThrough, color: Colors.grey)
                : TextStyle(decoration: TextDecoration.none))),
        onTap: (!widget.todo.isDone() ? editTask : null),
      )),
      widget.todo.isDone()
          ? SizedBox.shrink()
          : IconButton(
              icon: Icon(Icons.done),
              onPressed: () => crossTodoItem(widget.todo))
    ]);
  }
}
