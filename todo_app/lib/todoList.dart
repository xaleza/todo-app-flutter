import 'package:flutter/material.dart';
import 'package:todo_app/todoItem.dart';

class TodoList extends StatefulWidget {
  @override
  createState() => new TodoListState();
}

class TodoListState extends State<TodoList> {
  List<TodoItem> _todoItems = [];

  void _addTodoItem(String task) {
    if (task.length > 0) {
      setState(() {
        TodoItem todo = new TodoItem(task);
        _todoItems.add(todo);
      });
    }
  }

  // Build a single todo item
  Widget _buildTodoItem(TodoItem todo, int index) {
    return new Row(children: <Widget>[
      Expanded(
          child: ListTile(
        title: new Text(todo.getBody(),
            style: (todo.isDone()
                ? TextStyle(
                    decoration: TextDecoration.lineThrough, color: Colors.grey)
                : TextStyle(decoration: TextDecoration.none))),
      )),
      todo.isDone()
          ? SizedBox.shrink()
          : IconButton(
              icon: Icon(Icons.done), onPressed: () => _crossTodoItem(index))
    ]);
  }

  // Build the whole list of todo items
  Widget _buildTodoList() {
    return new ListView.builder(
      // ignore: missing_return
      itemBuilder: (context, index) {
        if (index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index], index);
        }
      },
    );
  }

  void _pushAddTodoScreen() {
    // Push this page onto the stack
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new Scaffold(
          appBar: new AppBar(title: new Text('Add a new task')),
          body: new TextField(
            autofocus: true,
            onSubmitted: (val) {
              _addTodoItem(val);
              Navigator.pop(context); // Close the add todo screen
            },
            decoration: new InputDecoration(
                hintText: 'Enter something to do...',
                contentPadding: const EdgeInsets.all(16.0)),
          ));
    }));
  }

  void _crossTodoItem(int index) {
    setState(() {
      _todoItems[index].markAsDone();
    });
  }

  void _removeAllTodoItem() {
    setState(() {
      _todoItems.clear();
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
          onPressed:
              _pushAddTodoScreen, // pressing this button now opens the new screen
          tooltip: 'Add task',
          child: new Icon(Icons.add)),
    );
  }
}
