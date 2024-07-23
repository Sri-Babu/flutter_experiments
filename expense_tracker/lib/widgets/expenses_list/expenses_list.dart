import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_items.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
   ExpensesList(
      {super.key, required this.expenses, required this.onRemoved});
  final void Function(Expense remove) onRemoved;

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    // List view builder is used when length is unknown
    return ListView.builder(
      // builder constructor will create the list only when they are visible
      itemCount: expenses.length,
      itemBuilder: (conxt, index) => Dismissible(
        key: ValueKey(expenses[index]),
        onDismissed: (direction) {
          onRemoved(expenses[index]);
        },
        child: ExpensesItems(
          expenses[index],
        ),
      ),
    );
  }
}
