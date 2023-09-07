import 'package:expense_app/components/expense_summary.dart';
import 'package:expense_app/components/expense_tile.dart';
import 'package:expense_app/data/expense_data.dart';
import 'package:expense_app/models/expense_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final newExpenseAmountController = TextEditingController();
  bool _isButtonDisabled = false;

  @override
  void initState() {
    super.initState();
    _isButtonDisabled = true;
    newExpenseAmountController.addListener(() {
      setState(() {
        _isButtonDisabled = newExpenseAmountController.text.isEmpty;
      });
    });
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  @override
  void dispose() {
    newExpenseAmountController.dispose();
    super.dispose();
  }

  //text controller
  final newExpenseNameController = TextEditingController();

  //add new expense
  void addNewExpense() {
    showDialog<bool>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('Enter new Expense'),
          content: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                CupertinoTextField(
                  controller: newExpenseNameController,
                  placeholder: 'Expense Name',
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: CupertinoColors.black,
                        width: 0.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                CupertinoTextField(
                  controller: newExpenseAmountController,
                  placeholder: 'Amount',
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                  ],
                  onChanged: (value) {
                    if (value.isEmpty) {
                      newExpenseAmountController.text = '0.0';
                    }
                  },
                  onSubmitted: (value) {
                    if (value.isEmpty) {
                      newExpenseAmountController.text = '0.0';
                    }
                  },
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: CupertinoColors.black,
                        width: 0.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: Text('Cancel', style: TextStyle(color: Colors.black)),
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
    if (newExpenseAmountController.text.isEmpty) {
      _isButtonDisabled = true;
      return;
    }
    ExpenseItem newExpense = ExpenseItem(
      amount: newExpenseAmountController.text,
      name: newExpenseNameController.text,
      datetime: DateTime.now(),
    );
    _isButtonDisabled ? null : () {};
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

  //delete expense
  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteNewExpense(expense);
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
          body: ListView(
            children: [
              SizedBox(
                height: 5,
              ),
              //weekly summary
              ExpenseSummary(startOfWeek: value.startOfWeekDay()),
              SizedBox(
                height: 5,
              ),
              //expense list
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: value.getAllExpenseItem().length,
                    itemBuilder: (context, index) => ExpenseTile(
                          name: value.getAllExpenseItem()[index].name,
                          amount: value.getAllExpenseItem()[index].amount,
                          dateTime: value.getAllExpenseItem()[index].datetime,
                          deleteTapped: ((p0) =>
                              deleteExpense(value.getAllExpenseItem()[index])),
                        )),
              ),
            ],
          )),
    );
  }
}
