import 'package:expense_tracker/chart.dart';
import 'package:expense_tracker/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense_data.dart';

import 'widgets/expenses_list.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  // create state
  @override
  State<Expenses> createState() => _ExpensesState();
}

// state class
class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        tittle: 'Flutter Course',
        amount: 19.59,
        category: Category.food,
        dateTime: DateTime.now()),
    Expense(
        tittle: 'Movies',
        amount: 16.34,
        category: Category.lesiure,
        dateTime: DateTime.now())
  ];
  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense); // add new expense items is submitted in list
    });
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,// it is used for full screen modal
        context: context,
        builder: (ctx) {
          return NewExpense(onAddExpense: _addExpense);
        });
  }

  void removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);// get index that we removed
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 3),
        content: SnackBarAction(
          onPressed: () {
            setState(() {
              // Inserts element at position index in this list.
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
          label: "Undo",
        )));
  }

// build method
  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text("No expense found! Start adding some!"),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: Card(
        child: Column(
          children: [
            // create custom chart widget
            Chart(expenses: _registeredExpenses),
            Expanded(child: mainContent)
          ],
        ),
      ),
    );
  }
}
