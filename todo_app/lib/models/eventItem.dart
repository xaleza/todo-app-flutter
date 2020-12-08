import 'package:flutter/material.dart';
import 'package:todo_app/models/todoItem.dart';

class EventItem extends TodoItem {
  EventItem(String body) : super(body);
  Icon _icon = Icon(
    Icons.event_note,
    size: 25,
    color: Colors.black,
  );
  Icon _iconDone = Icon(Icons.event_available, size: 25);

  @override
  Widget getIcon() {
    return _icon;
  }

  @override
  bool isEvent() {
    return true;
  }

  @override
  void markAsDone() {
    _icon = _iconDone;
    super.markAsDone();
  }
}
