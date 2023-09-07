import 'package:hive_flutter/adapters.dart';

import '../models/expense_item.dart';

class HiveDatabase {
  final _myBox = Hive.box("expense_database");

  //write date in hive
  void saveData(List<ExpenseItem> allExpense) {
    List<List<dynamic>> allExpensesFormated = [];
    for (var expense in allExpense) {
      List<dynamic> expenseFormated = [
        expense.name,
        expense.amount,
        expense.datetime,
      ];
      allExpensesFormated.add(expenseFormated);
    }
    _myBox.put("ALL_EXPENSES", allExpensesFormated);
  }

  //read data from hive
  List<ExpenseItem> readData() {
    List savedExpenses = _myBox.get("ALL_EXPENSES") ?? [];
    List<ExpenseItem> allExpense = [];

    for (int i = 0; i < savedExpenses.length; i++) {
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];

      ExpenseItem expense =
          ExpenseItem(amount: amount, name: name, datetime: dateTime);
      allExpense.add(expense);
    }
    return allExpense;
  }
}
