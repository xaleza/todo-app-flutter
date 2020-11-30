//Screen with the "daily" view

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/models/todoItem.dart';
import 'package:todo_app/screens/addTodoScreen.dart';
import 'package:todo_app/widgets/todoCard.dart';

class DailyScreen extends StatefulWidget {
  @override
  createState() => new DailyScreenState();
}

class DailyScreenState extends State<DailyScreen> {
  List<TodoItem> _todoItems = [];

  //builds Add task screen
  void _addTask() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddTodoScreen(_todoItems, context)),
    );
    if (result) {
      setState(() {});
    }
  }

  // Build the whole list of todo items
  Widget _buildTodoList() {
    return new ListView.builder(
      // ignore: missing_return
      itemBuilder: (context, index) {
        if (index < _todoItems.length) {
          return Slidable(
            actionPane: SlidableDrawerActionPane(),
            child: TodoCard(_todoItems[index], index),
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () => removeTodoItem(index),
              ),
            ],
          );
        }
      },
    );
  }

  void _removeAllTodoItem() {
    setState(() {
      _todoItems.clear();
    });
  }

  void removeTodoItem(int index) {
    setState(() {
      _todoItems.removeAt(index);
    });
  }

  void clearTodoItems() {
    setState(() {
      _promptRemoveAllTodoItem();
    });
  }

  // Show an alert dialog asking the user to confirm that the task is done
  void _promptRemoveAllTodoItem() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
              title: new Text('Clear Todo List?'),
              actions: <Widget>[
                new FlatButton(
                    child: new Text('CANCEL'),
                    onPressed: () => Navigator.of(context).pop()),
                new FlatButton(
                    child: new Text('CLEAR'),
                    onPressed: () {
                      _removeAllTodoItem();
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Todo List'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.delete_forever),
              onPressed: this._promptRemoveAllTodoItem)
        ],
      ),
      body: _buildTodoList(),
      floatingActionButton: new FloatingActionButton(
          onPressed: _addTask, // pressing this button now opens the new screen
          tooltip: 'Add task',
          child: new Icon(Icons.add)),
    );
  }
}
