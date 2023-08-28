import 'package:flutter/material.dart';
import 'package:walletapp/data/hive_database.dart';
import 'package:walletapp/datetime/date_time_helper.dart';
import 'package:walletapp/models/expense_item.dart';

class ExpenseData extends ChangeNotifier {
  // List of expenses
  List<ExpenseItem> overallExpenseList = [];

  // get expense list
  List<ExpenseItem> getAllExpnseList() {
    return overallExpenseList;
  }

  // prepare data to display
  final db = HiveDatabase();
  void prepareData() {
    if (db.readData().isNotEmpty) {
      overallExpenseList = db.readData();
    }
  }

  // add new expnse
  void addNewExpense(ExpenseItem expenseItem) {
    overallExpenseList.add(expenseItem);

    notifyListeners();
    db.saveData(overallExpenseList);
  }

  // delete expense
  void deleteExpnse(ExpenseItem expenseItem) {
    overallExpenseList.remove(expenseItem);

    notifyListeners();
    db.saveData(overallExpenseList);
  }

  // get weekday (mon, tue, wes, etc) from dateTime object
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Sun';
      case 2:
        return 'Mon';
      case 3:
        return 'Tue';
      case 4:
        return 'Wed';
      case 5:
        return 'Thur';
      case 6:
        return 'Fri';
      case 7:
        return 'Sat';
      default:
        return '';
    }
  }

  // get the date for the start of the week (sunday)
  DateTime startOfWeekDay() {
    DateTime? startOfWeek;

    DateTime today = DateTime.now();

    for (var i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sun') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }

    return startOfWeek!;
  }

  /*
  
  convert all list of expnses into a daily expnse summary

  e.g.

  overallExpnseList =
  [
    [food, 2023/08/22, $10],
    [food, 2023/08/22, $10],
  ]

  ->

  DailyExonseSummary =
  [
    [2023/08/22, $10]
  ]

  */

  Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {};

    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }
    return dailyExpenseSummary;
  }
}
