import 'package:hive_flutter/hive_flutter.dart';

import '../models/expanse_item_model.dart';

class HiveDataBase {
  // reference our box
  final _myBox = Hive.box('expense_database');

  // write data
  void saveData(List<ExpanseItem> allExpense) {
    List<List<dynamic>> allExpenseFormatted = [];
    for (var expense in allExpense) {
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime
      ];
      allExpenseFormatted.add(expenseFormatted);
      _myBox.put("ALL_EXPENSES", allExpenseFormatted);
    }
  }

  // read data
  List<ExpanseItem> readData() {
    List savedExpenses = _myBox.get("ALL_EXPENSES") ?? [];
    List<ExpanseItem> allExpenses = [];
    for (int i = 0; i < savedExpenses.length; i++) {
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime datetime = savedExpenses[i][2];

      // create expense item
      ExpanseItem expense = ExpanseItem(
        name: name,
        amount: amount,
        dateTime: datetime,
      );
      allExpenses.add(expense);
    }
    return allExpenses;
  }
}
