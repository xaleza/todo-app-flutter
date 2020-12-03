import 'package:todo_app/models/month.dart';

class Year {
  int _year;
  List<Month> _months;

  Year(this._year) {
    for (var i = 1; i <= 12; i++) {
      _months.add(new Month(i, _year));
    }
  }

  int getYear() {
    return _year;
  }

  List getMonths() {
    return _months;
  }
}
