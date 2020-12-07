//  Copyright (c) 2019 Aleksander Woźniak
//  Licensed under Apache License v2.0

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/models/calendar/day.dart';
import 'package:todo_app/models/calendar/month.dart';
import 'package:todo_app/models/calendar/year.dart';
import 'package:todo_app/models/todoItem.dart';

// Example holidays
final Map<DateTime, List> _holidays = {};

class MonthlyScreen extends StatefulWidget {
  final Year year;

  MonthlyScreen(this.year);
  @override
  createState() => new MonthlyScreenState();
}

class MonthlyScreenState extends State<MonthlyScreen>
    with TickerProviderStateMixin {
  Map<DateTime, List> _events = Map<DateTime, List>();
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();

    widget.year.getMonths().forEach((month) {
      List<Day> days = month.getDays();
      days.forEach((day) {
        String formatedDate = day.getDay().toString() +
            "/" +
            month.getMonth().toString() +
            "/" +
            widget.year.getYear().toString();
        List<TodoItem> todos = day.getTodos();
        print(todos);
        if (todos.isNotEmpty)
          _events.addAll({DateFormat('d/M/yyyy').parse(formatedDate): todos});
      });
    });
    print(_selectedDay);
    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Monthly View"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          // Switch out 2 lines below to play with TableCalendar's settings
          //-----------------------
          _buildTableCalendar(),
          // _buildTableCalendarWithBuilders(),
          const SizedBox(height: 8.0),
          _buildButtons(),
          const SizedBox(height: 8.0),
          Expanded(child: _buildEventList()),
        ],
      ),
    );
  }

  // Simple TableCalendar configuration (using Styles)
  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      availableCalendarFormats: const {CalendarFormat.month: "Month"},
      holidays: _holidays,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.blueGrey[600],
        todayColor: Colors.blueGrey[300],
        markersColor: Colors.black,
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
        formatButtonTextStyle:
            TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildButtons() {
    //final dateTime = _events.keys.elementAt(_events.length - 2);

    return SizedBox.shrink();
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map((event) => Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.8),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                  leading: event.getIcon(),
                  title: new Text(event.getBody(),
                      style: (event.isDone() && !event.isNote()
                          ? TextStyle(color: Colors.grey)
                          : TextStyle(decoration: TextDecoration.none))),
                  onTap: () => print('$event tapped!'),
                ),
              ))
          .toList(),
    );
  }
}
