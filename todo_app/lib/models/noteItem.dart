import 'package:flutter/material.dart';
import 'package:todo_app/models/todoItem.dart';

class NoteItem extends TodoItem {
  NoteItem(String body) : super(body);
  Icon _icon = Icon(Icons.remove, size: 18, color: Colors.black);

  @override
  bool isNote() {
    return true;
  }

  @override
  Widget getIcon() {
    return _icon;
  }

  @override
  void markAsDone() {
    super.markAsDone();
    _icon = _icon;
  }
}
