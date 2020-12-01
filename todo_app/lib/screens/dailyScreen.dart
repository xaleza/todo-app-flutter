//Screen with the "daily" view

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:scrolling_day_calendar/scrolling_day_calendar.dart';
import 'package:todo_app/models/todoItem.dart';
import 'package:todo_app/screens/addTodoScreen.dart';
import 'package:todo_app/widgets/todoCard.dart';
import 'package:intl/intl.dart';

class DailyScreen extends StatefulWidget {
  @override
  createState() => new DailyScreenState();
}

class DailyScreenState extends State<DailyScreen> {
  Map<String, List<TodoItem>> _todoItems = Map();
  DateTime selectedDate = DateTime.now();
  DateTime startDate = DateTime.now().subtract(Duration(days: 200));
  DateTime endDate = DateTime.now().add(Duration(days: 200));

  // this date will update every time the page changes
  DateTime _currentPageDate;

  // stores the todoCards in each date
  Map<String, Widget> widgets = Map();
  String widgetKeyFormat = "yyyy-MM-dd";

  // builds all the todo lists for all days
  _buildPages() {
    _todoItems.forEach((key, values) {
      DateTime dateTime = DateTime.parse(key);
      var widget = _buildTodoList(dateTime);
      widgets.addAll({key: widget});
    });
  }

  //builds Add task screen
  void _addTask() async {
    String dateString = DateFormat(widgetKeyFormat).format(_currentPageDate);
    if (!_todoItems.containsKey(dateString)) {
      _todoItems.addAll({dateString: []});
    }
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddTodoScreen(_todoItems[dateString], context)),
    );
    if (result) {
      setState(() {
        print(_todoItems.keys);
        _buildPages();
      });
    }
  }

  // Build the list of Todos for a given date
  Widget _buildTodoList(DateTime date) {
    String dateString = DateFormat(widgetKeyFormat).format(date);
    if (_todoItems.containsKey(dateString)) {
      List<TodoItem> items = _todoItems[dateString];
      return new ListView.builder(
        // ignore: missing_return
        itemCount: items.length,
        itemBuilder: (context, index) {
          if (index < _todoItems[dateString].length) {
            return Slidable(
              actionPane: SlidableDrawerActionPane(),
              child: TodoCard(items[index], index),
              secondaryActions: <Widget>[
                IconSlideAction(
                  caption: 'Delete',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () => removeTodoItem(index),
                ),
              ],
            );
          }
          return Center(
            child: Text("No events"),
          );
        },
      );
    }
    // default widget to display on the page
    return Center(
      child: Text("No events"),
    );
  }

  void _removeAllTodoItem() {
    setState(() {
      _todoItems.clear();
      widgets.clear();
      _buildPages();
    });
  }

  void removeTodoItem(int index) {
    String dateString = DateFormat(widgetKeyFormat).format(_currentPageDate);
    setState(() {
      _todoItems[dateString].removeAt(index);
      _buildPages();
    });
  }

  void clearTodoItems() {
    setState(() {
      _promptRemoveAllTodoItem();
    });
  }

  // Show an alert dialog asking the user to confirm that the task is done
  void _promptRemoveAllTodoItem() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
              title: new Text('Clear Todo List?'),
              actions: <Widget>[
                new FlatButton(
                    child: new Text('CANCEL'),
                    onPressed: () => Navigator.of(context).pop()),
                new FlatButton(
                    child: new Text('CLEAR'),
                    onPressed: () {
                      _removeAllTodoItem();
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }

  @override
  void initState() {
    _buildPages();
    _currentPageDate = selectedDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Todo List'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.delete_forever),
              onPressed: this._promptRemoveAllTodoItem)
        ],
      ),
      // ignore: missing_required_param
      body: ScrollingDayCalendar(
        startDate: startDate,
        endDate: endDate,
        selectedDate: selectedDate,
        dateStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        displayDateFormat: "dd, MMM yyyy",
        dateBackgroundColor: Colors.blueGrey[600],
        forwardIcon: Icons.arrow_forward,
        backwardIcon: Icons.arrow_back,
        pageChangeDuration: Duration(
          milliseconds: 500,
        ),
        onDateChange: (direction, DateTime date) {
          _currentPageDate = date;
        },
        widgets: widgets,
        widgetKeyFormat: widgetKeyFormat,
        noItemsWidget: Center(child: Text("No events")),
      ),
      floatingActionButton: new FloatingActionButton(
          onPressed: _addTask, // pressing this button now opens the new screen
          tooltip: 'Add task',
          child: new Icon(Icons.add)),
    );
  }
}
