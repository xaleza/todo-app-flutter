import 'package:flutter/material.dart';
import 'package:todo_app/models/todoItem.dart';

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

  @override
  Widget build(BuildContext context) {
    return new Row(children: <Widget>[
      Expanded(
          child: ListTile(
        title: new Text(widget.todo.getBody(),
            style: (widget.todo.isDone()
                ? TextStyle(
                    decoration: TextDecoration.lineThrough, color: Colors.grey)
                : TextStyle(decoration: TextDecoration.none))),
      )),
      widget.todo.isDone()
          ? SizedBox.shrink()
          : IconButton(
              icon: Icon(Icons.done),
              onPressed: () => crossTodoItem(widget.todo))
    ]);
  }
}
