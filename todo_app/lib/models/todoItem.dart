// A single item of the Todo list

import 'package:flutter/cupertino.dart';

abstract class TodoItem {
  String _body;
  bool _isDone = false;

  TodoItem(this._body);

  String getBody() {
    return _body;
  }

  bool isDone() {
    return _isDone;
  }

  void markAsDone() {
    _isDone = true;
  }

  void editBody(String body) {
    _body = body;
  }

  bool isNote() {
    return false;
  }

  bool isEvent() {
    return false;
  }

  Widget getIcon();
}
