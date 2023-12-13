import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

import '../../dictionary/category.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;

  const ExpenseItem(this.expense, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(children: [
              Text('\$${expense.amount.toStringAsFixed(2)}'),
              const Spacer(),
              Icon(categoryIcons[expense.category]),
              const SizedBox(
                width: 5,
              ),
              Text(expense.formattedDate),
            ])
          ],
        ),
      ),
    );
  }
}
