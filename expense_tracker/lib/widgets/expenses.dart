import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widgets/new_expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _ecpensesList = [
    Expense(
      title: 'Udemey Cource',
      amount: 850,
      date: DateTime.now(),
      category: Categories.work,
    ),
    Expense(
      title: 'Manjumal Boys',
      amount: 378,
      date: DateTime.now(),
      category: Categories.leisure,
    ),
  ];
  void _operAddExpensesOverley() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpenses(
              onAddExpense: _addNewExpese,
            ));
  }

  void _addNewExpese(Expense newExpense) {
    setState(() {
      _ecpensesList.add(newExpense);
    });
  }

  void _removeExpense(Expense removedExpense) {
    // This will help us to find the index of removed expense
    final expenseIndex = _ecpensesList.indexOf(removedExpense);
    setState(() {
      _ecpensesList.remove(removedExpense);
    });

    // remove the exixting snack bar if presenst
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    // showes new snack bar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense Deleted!'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(
              () {
                // with the help of the index we can insert the expense in the same place using insert method in the list
                _ecpensesList.insert(expenseIndex, removedExpense);
              },
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(child: Text('No Expenses Added'));
    if (_ecpensesList.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _ecpensesList,
        onRemoved: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.teal[300]),
        title: const Text("Expense Tracker"),
        centerTitle: true,
        backgroundColor: Colors.teal[300],
        leading: IconButton(
          onPressed: _operAddExpensesOverley,
          icon: const Icon(Icons.add),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Chart(expenses: _ecpensesList),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
