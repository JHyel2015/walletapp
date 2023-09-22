import 'package:hive_flutter/hive_flutter.dart';
import '../models/expense_item.dart';

class HiveDatabase {
  // reference our boc
  final _myBox = Hive.box("expense_database");

  // write data
  void saveData(List<ExpenseItem> allExpense) {
    List<List<dynamic>> allExpensesFormatted = [];

    for (var expense in allExpense) {
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime,
        expense.status,
        expense.categoryId,
        expense.type,
        expense.bankId,
        expense.recurrent,
        expense.repeated,
        expense.ignored,
      ];
      allExpensesFormatted.add(expenseFormatted);
    }

    _myBox.put("ALL_EXPENSES", allExpensesFormatted);
  }

  // read data
  List<ExpenseItem> readData() {
    List savedExpenses = _myBox.get("ALL_EXPENSES") ?? [];
    List<ExpenseItem> allExpenses = [];

    for (var i = 0; i < savedExpenses.length; i++) {
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];
      bool status = savedExpenses[i][3];
      int categoryId = savedExpenses[i][4];
      int type = savedExpenses[i][5];
      int bankId = savedExpenses[i][6];
      bool recurrent = savedExpenses[i][7];
      bool repeated = savedExpenses[i][8];
      bool ignored = savedExpenses[i][9];

      ExpenseItem expense = ExpenseItem(
        name: name,
        amount: amount == '' ? '0' : amount,
        dateTime: dateTime,
        status: status,
        categoryId: categoryId,
        type: type,
        bankId: bankId,
        recurrent: recurrent,
        repeated: repeated,
        ignored: ignored,
      );

      allExpenses.add(expense);
    }
    return allExpenses;
  }
}
