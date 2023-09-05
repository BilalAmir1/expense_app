import 'package:expense_app/components/expense_tile.dart';
import 'package:expense_app/data/expense_data.dart';
import 'package:expense_app/models/expense_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final newExpenseAmountController = TextEditingController();
  //text controller
  final newExpenseNameController = TextEditingController();

  //add new expense
  void addNewExpense() {
    showDialog<bool>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('Enter new Expense'),
          content: Column(
            children: [
              CupertinoTextField(
                controller: newExpenseNameController,
                placeholder: 'Expense Name',
              ),
              SizedBox(height: 10),
              CupertinoTextField(
                controller: newExpenseAmountController,
                placeholder: 'Amount',
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            CupertinoDialogAction(
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () => cancel(),
            ),
            CupertinoDialogAction(
              child: Text('Save', style: TextStyle(color: Colors.black)),
              onPressed: () => save(),
            ),
          ],
        );
      },
    );
    ;
  }

  //save function
  void save() {
    ExpenseItem newExpense = ExpenseItem(
        amount: newExpenseAmountController.text,
        name: newExpenseNameController.text,
        datetime: DateTime.now());
    Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);
    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newExpenseAmountController.clear();
    newExpenseNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey[200],
        floatingActionButton: FloatingActionButton(
          onPressed: addNewExpense,
          child: Icon(Icons.add),
        ),
        body: ListView.builder(
            itemCount: value.getAllExpenseItem().length,
            itemBuilder: (context, index) => ExpenseTile(
                name: value.getAllExpenseItem()[index].name,
                amount: value.getAllExpenseItem()[index].amount,
                dateTime: value.getAllExpenseItem()[index].datetime)),
      ),
    );
  }
}
