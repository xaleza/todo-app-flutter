// A single item of the Todo list

class TodoItem {
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
}
