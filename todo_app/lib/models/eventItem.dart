import 'package:flutter/material.dart';
import 'package:todo_app/models/todoItem.dart';

class EventItem extends TodoItem {
  EventItem(String body) : super(body);

  @override
  Widget symbol() {
    return new Icon(Icons.event_note, size: 18);
  }
}
