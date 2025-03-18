import 'package:flutter/material.dart';

import '../models/expense_data.dart';
import 'expenses_item.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> expenses;
  final Function(Expense expense) onRemoveExpense;
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});
  @override
  Widget build(BuildContext context) {
    // listview constructor function
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          print("Expense ==>${expenses[index]}");
          return Dismissible( //Flutter Dismissible Widget swipe both ways
            background: Container(
              color: Theme.of(context).colorScheme.error.withOpacity(0.75),
              margin: EdgeInsets.symmetric(
                horizontal: Theme.of(context).cardTheme.margin!.horizontal
              ),
            ),
              onDismissed: (direction) {
                onRemoveExpense(expenses[index]);
              },
              key: ValueKey(expenses[index]),// key is used for sync with list
              child: ExpensesItem(
                  expense: expenses[
                      index])); //The [key] argument is required because [Dismissible]s are commonly used in lists and removed from the list when dismissed.
        });
  }
}
