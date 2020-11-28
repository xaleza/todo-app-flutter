import 'package:flutter/material.dart';
import 'package:todo_app/models/todoItem.dart';

class NoteItem extends TodoItem {
  NoteItem(String body) : super(body);

  @override
  Widget symbol() {
    return new Icon(Icons.remove, size: 18);
  }
}
