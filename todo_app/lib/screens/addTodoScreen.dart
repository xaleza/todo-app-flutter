//Screen used to add tasks
import 'package:flutter/material.dart';
import 'package:todo_app/models/calendar/day.dart';
import 'package:todo_app/models/eventItem.dart';
import 'package:todo_app/models/noteItem.dart';
import 'package:todo_app/models/taskItem.dart';

class AddTodoScreen extends StatefulWidget {
  final Day day;
  final BuildContext context;

  AddTodoScreen(this.day, this.context);

  @override
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  TextEditingController _addingController;
  List<bool> _selections = [true, false, false];

  @override
  void initState() {
    super.initState();
    _addingController = TextEditingController();
  }

  @override
  void dispose() {
    _addingController.dispose();
    super.dispose();
  }

  Widget typeOfTodo() {
    return ToggleButtons(
      children: <Widget>[
        Column(children: [
          Icon(
            Icons.fiber_manual_record,
            size: 30,
          ),
          Text(
            "Task",
            style: TextStyle(fontSize: 20),
          )
        ]),
        Column(children: [
          Icon(
            Icons.event_note,
            size: 30,
          ),
          Text("Event", style: TextStyle(fontSize: 20))
        ]),
        Column(children: [
          Icon(
            Icons.remove,
            size: 30,
          ),
          Text("Note", style: TextStyle(fontSize: 20))
        ]),
      ],
      isSelected: _selections,
      onPressed: (int index) {
        setState(() {
          for (int buttonIndex = 0;
              buttonIndex < _selections.length;
              buttonIndex++) {
            if (buttonIndex == index) {
              _selections[buttonIndex] = true;
            } else {
              _selections[buttonIndex] = false;
            }
          }
        });
      },
    );
  }

  void _addTodoItem(String task) {
    if (task.length > 0) {
      if (_selections[0])
        widget.day.addTodo(new TaskItem(task));
      else if (_selections[1])
        widget.day.addTodo(new EventItem(task));
      else
        widget.day.addTodo(new NoteItem(task));
    }
  }

  Widget _addTaskTextField() {
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      onSubmitted: (val) {
        setState(() {
          _addTodoItem(val);
          Navigator.pop(widget.context, true);
        });
      },
      decoration:
          new InputDecoration(contentPadding: const EdgeInsets.all(16.0)),
      autofocus: true,
      controller: _addingController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new task"),
      ),
      body: Column(
        children: [
          _addTaskTextField(),
          SizedBox(
            height: 15,
          ),
          typeOfTodo()
        ],
      ),
    );
  }
}
