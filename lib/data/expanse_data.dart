import 'package:expense_tracker_app/data/hive_database.dart';
import 'package:expense_tracker_app/datetime/date_time_helper.dart';
import 'package:flutter/material.dart';

import '../models/expanse_item_model.dart';

class ExpanseData extends ChangeNotifier {
// list of all expanses
  List<ExpanseItem> overallExpanseList = [];

// get expanse list
  List<ExpanseItem> getAllExpanseList() {
    return overallExpanseList;
  }
  final db = HiveDataBase();
// prepare data
  void prepareData(){
      if(db.readData().isNotEmpty){
        overallExpanseList = db.readData();
      }
  }
// add new expanse
  void addNewExpanse(ExpanseItem newExpanse) {
    overallExpanseList.add(newExpanse);
    db.saveData(overallExpanseList);
    notifyListeners();
  }

// delete expanse
  void deleteExpanse(ExpanseItem expanse) {
    overallExpanseList.remove(expanse);
    db.saveData(overallExpanseList);
    notifyListeners();
  }

// get weekday(mon,tues,wed,etc..) datetime object
  String getDayName(DateTime datetime) {
    switch (datetime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tues';
      case 3:
        return 'Wed';
      case 4:
        return 'Thur';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

// get the date for the start of the week (sunday)
  DateTime startOfWeekDate() {
    DateTime today = DateTime.now();
    int daysToSubtract = today.weekday %
        7; // Calculating days to subtract to get to the most recent Sunday
    return today.subtract(Duration(days: daysToSubtract));
  }

/*
    convert overall list of expanses into a daily expanse summery

    e.g .

    [
      [food,2023/09/03 $10],
      [drink,2023/09/04 $12],
      [food,2023/09/13 $1],
    ]

    ->
    daily expanse summery =
    [

    [2023/01/03 $110]
    [2023/01/04 $10]
    [2023/01/05 $120]

    ]

 */

  Map<String, double> calculateDailyExpanseSummery() {
    Map<String, double> dailyExpanseSummery = {
      // date (yyyymmdd) total amount of the day
    };
    for (var expense in overallExpanseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);
      if (dailyExpanseSummery.containsKey(date)) {
        double currentAmount = dailyExpanseSummery[date]!;
        currentAmount += amount;
        dailyExpanseSummery[date] = currentAmount;
      } else {
        dailyExpanseSummery.addAll({date: amount});
      }
    }
    return dailyExpanseSummery;
  }
}
