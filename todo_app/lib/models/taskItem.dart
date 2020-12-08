import 'package:flutter/material.dart';
import 'package:todo_app/models/todoItem.dart';

class TaskItem extends TodoItem {
  TaskItem(String body) : super(body);
  Icon _icon = Icon(Icons.fiber_manual_record, size: 18, color: Colors.black);
  Icon _iconDone = Icon(Icons.done);

  @override
  Widget getIcon() {
    return _icon;
  }

  @override
  void markAsDone() {
    super.markAsDone();
    _icon = _iconDone;
  }
}
