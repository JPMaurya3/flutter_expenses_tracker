import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

// uuid package is used to get unique id
const uuid = Uuid();
var formatter = DateFormat().add_yMd();

// contains all the value we have used in category
enum Category { food, travel, lesiure, work }

var categoryIcons = {
  Category.food: Icons.dinner_dining,
  Category.travel: Icons.flight_takeoff,
  Category.lesiure: Icons.movie,
  Category.work: Icons.work
};

class Expense {
  final String? id;
  final String tittle;
  final double amount;
  final Category category;
  final DateTime dateTime;
  Expense({required this.tittle, required this.amount,required this.category,required this.dateTime}):id =uuid.v4();

  get formattedDate {
    return formatter.format(dateTime);
  }
}
//store all expenses of a all particular category
/* add expense to related category*/
class ExpenseBucket {
  final Category category;
  final List<Expense> expenses;
  ExpenseBucket(this.category, this.expenses);
  // extra constructor for adding expenses to specific category
  ExpenseBucket.forCategory(List<Expense> allExpenses,
      this.category) //here we used expenseBucket category
      : expenses = allExpenses  // : colon indicate initializer list
       // where is the method to allow filter a list
            .where((expense) => expense.category == category)
            .toList();
//accept a particular category and expensed and create a list of all expenses
  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
