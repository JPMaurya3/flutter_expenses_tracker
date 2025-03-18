import 'package:expense_tracker/models/expense_data.dart';
import 'package:flutter/material.dart';

import 'charbar.dart';

class Chart extends StatelessWidget {
  final List<Expense> expenses;
  const Chart({super.key, required this.expenses});

  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(expenses, Category.food),
      ExpenseBucket.forCategory(expenses, Category.lesiure),
      ExpenseBucket.forCategory(expenses, Category.work),
      ExpenseBucket.forCategory(expenses, Category.travel),
    ];
  }

  double get maxTotalExpenses {
    double maxTotalExpense = 0;
    for (final bucket in buckets) {
      if (bucket.totalExpenses > maxTotalExpense) {
        maxTotalExpense = bucket.totalExpenses;
      }
    }
    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    final  isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Theme.of(context).colorScheme.primary.withOpacity(0.3),
          Theme.of(context).colorScheme.primary.withOpacity(0.0)
        ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets) // alternate to map
                  ChartBar(
                    fill: bucket.totalExpenses == 0 ? 0 : bucket.totalExpenses / maxTotalExpenses,
                  )
              ],
            ),
          ),
          const SizedBox(height: 16,),
          Row(children: buckets.map((bucket)=>Expanded(
            child: Icon(categoryIcons[bucket.category],
            color: isDarkMode ? Theme.of(context).colorScheme.secondary:Theme.of(context).primaryColor.withOpacity(0.7),
),

          )).toList())
        ],
      ),
    );
  }
}
