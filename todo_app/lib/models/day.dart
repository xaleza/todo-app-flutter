import 'package:todo_app/models/todoItem.dart';

class Day {
  int _day;
  List<TodoItem> _todoItems = [];

  Day(this._day);

  int getDay() {
    return _day;
  }

  List getTodos() {
    return _todoItems;
  }

  void addTodo(TodoItem todo) {
    _todoItems.add(todo);
  }
}
