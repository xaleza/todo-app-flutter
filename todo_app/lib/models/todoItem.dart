// A single item of the Todo list

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoItem {
  String _body;
  bool _isDone = false;
  Icon _icon = Icon(Icons.fiber_manual_record, size: 18, color: Colors.black);
  Icon _iconDone = Icon(Icons.done);

  TodoItem(this._body);

  String getBody() {
    return _body;
  }

  bool isDone() {
    return _isDone;
  }

  void markAsDone() {
    _isDone = true;
    _icon = _iconDone;
  }

  void editBody(String body) {
    _body = body;
  }

  Widget getIcon() {
    return _icon;
  }

  bool isNote() {
    return false;
  }
}
