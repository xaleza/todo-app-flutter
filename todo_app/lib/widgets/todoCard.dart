//Widget that holds a task

import 'package:flutter/material.dart';
import 'package:todo_app/models/todoItem.dart';
import 'package:todo_app/screens/editTodoScreen.dart';

class TodoCard extends StatefulWidget {
  final TodoItem todo;

  const TodoCard(this.todo);

  @override
  _TodoCardState createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  void crossTodoItem() {
    setState(() {
      widget.todo.markAsDone();
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

  Widget todoIcon() {
    return new IconButton(
        //prevents click effect on notes
        splashColor: widget.todo.isNote() ? Colors.transparent : Colors.grey,
        icon: widget.todo.getIcon(),
        onPressed: crossTodoItem);
  }

  @override
  Widget build(BuildContext context) {
    return new Row(children: <Widget>[
      Expanded(
          child: ListTile(
        leading: todoIcon(),
        title: new Text(widget.todo.getBody(),
            style: (widget.todo.isDone() && !widget.todo.isNote()
                ? TextStyle(color: Colors.grey)
                : TextStyle(decoration: TextDecoration.none))),
        onTap:
            //if the widget is done and not a note, it cannot be edited,
            (!widget.todo.isDone() || widget.todo.isNote() ? editTask : null),
      )),
    ]);
  }
}
