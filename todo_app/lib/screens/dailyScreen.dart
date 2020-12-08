//Screen with the "daily" view

import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:scrolling_day_calendar/scrolling_day_calendar.dart';
import 'package:todo_app/models/calendar/month.dart';
import 'package:todo_app/models/todoItem.dart';
import 'package:todo_app/models/calendar/year.dart';
import 'package:todo_app/screens/addTodoScreen.dart';
import 'package:todo_app/screens/monthlyScreen.dart';
import 'package:todo_app/widgets/todoCard.dart';

class DailyScreen extends StatefulWidget {
  @override
  createState() => new DailyScreenState();
}

class DailyScreenState extends State<DailyScreen> {
  Year year = new Year(2020);
  DateTime selectedDate = DateTime.now();
  DateTime startDate =
      DateTime.utc(DateTime.now().year, DateTime.now().month, 1);
  DateTime endDate = DateTime.utc(DateTime.now().year, DateTime.now().month,
      DateUtil().daysInMonth(DateTime.now().month, DateTime.now().year));

  // this date will update every time the page changes
  DateTime _currentPageDate;
  Month _currentMonth;

  // stores the todoCards in each date
  Map<String, Widget> widgets = Map();
  String widgetKeyFormat = "yyyy-MM-dd";

  // builds all the todo lists for all days
  _buildPages() {
    List days = _currentMonth.getDays();
    days.forEach((day) {
      String dayString;
      if (day.getDay() < 9)
        dayString = "0" + (day.getDay() + 1).toString();
      else
        dayString = (day.getDay() + 1).toString();
      String formatedDate = year.getYear().toString() +
          "-" +
          _currentMonth.getMonth().toString() +
          "-" +
          dayString;
      day.getDay().toString();
      var widget = _buildTodoList(day.getDay());
      widgets.addAll({formatedDate: widget});
    });
  }

  //builds Add task screen
  void _addTask() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddTodoScreen(
              _currentMonth.getDay(_currentPageDate.day), context)),
    );
    if (result) {
      setState(() {
        _buildPages();
      });
    }
  }

  // Build the list of Todos for a given date
  Widget _buildTodoList(int day) {
    List<TodoItem> items = _currentMonth.getDay(day).getTodos();
    if (items.isNotEmpty)
      return new ListView.builder(
          // ignore: missing_return
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Slidable(
              actionPane: SlidableDrawerActionPane(),
              child: TodoCard(items[index]),
              actions: <Widget>[
                IconSlideAction(
                  caption: 'Forward',
                  color: Colors.blue,
                  icon: Icons.double_arrow,
                  onTap: () => /* forwardTodoItem(index) */ null,
                )
              ],
              secondaryActions: <Widget>[
                IconSlideAction(
                  caption: 'Delete',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () => removeTodoItem(index),
                ),
              ],
            );
          });
    // default widget to display on the page
    return Center(
      child: Text("No events"),
    );
  }

  void _removeAllTodoItem() {
    setState(() {
      widgets.clear();
      _buildPages();
    });
  }

  void removeTodoItem(int index) {
    setState(() {
      _currentMonth.getDay(_currentPageDate.day).getTodos().removeAt(index);
      _buildPages();
    });
  }

  /* void forwardTodoItem(int index) {
    String dateString = DateFormat(widgetKeyFormat).format(_currentPageDate);
    String dateStringNew = DateFormat(widgetKeyFormat)
        .format(_currentPageDate.add(Duration(days: 1)));
    TodoItem todo =
        _currentMonth.getDay(_currentPageDate.day).getTodos()[index];
    if (!_todoItems.containsKey(dateStringNew)) {
      _todoItems.addAll({dateStringNew: []});
    }
    setState(() {
      _todoItems[dateString].removeAt(index);
      _todoItems[dateStringNew].add(todo);
      _buildPages();
    });
  } */

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

  void monthlyVew() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MonthlyScreen(this.year)),
    );
    if (result) {
      setState(() {});
    }
  }

  @override
  void initState() {
    _currentPageDate = selectedDate;
    _currentMonth = year.getMonth(_currentPageDate.month);
    _buildPages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Todo List'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.calendar_today), onPressed: this.monthlyVew),
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
          _currentMonth = year.getMonth(_currentPageDate.month);
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
