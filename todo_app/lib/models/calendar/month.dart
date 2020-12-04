import 'package:date_util/date_util.dart';
import 'package:todo_app/models/calendar/day.dart';

class Month {
  int _year;
  int _month;
  int _numOfDays;
  List<Day> _days = List<Day>();
  var dateUtility = DateUtil();

  Month(this._month, this._year) {
    _numOfDays = dateUtility.daysInMonth(_month, _year);
    for (var i = 1; i <= _numOfDays; i++) {
      Day day = new Day(i);
      _days.add(day);
    }
  }

  int getMonth() {
    return _month;
  }

  int getNumOfDays() {
    return _numOfDays;
  }

  List getDays() {
    return _days;
  }

  Day getDay(int d) {
    return _days[d - 1];
  }
}
