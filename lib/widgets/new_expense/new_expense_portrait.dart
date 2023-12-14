import 'package:expense_tracker/dictionary/category.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExpensePortrait extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController amountController;
  final Category selectedCategory;
  final DateTime? selectedDate;
  final Function() displayDatePicker;
  final Function(Category?) updateCategory;
  final Function() submitExpense;

  const NewExpensePortrait({
    super.key,
    this.selectedDate,
    required this.titleController,
    required this.amountController,
    required this.selectedCategory,
    required this.displayDatePicker,
    required this.updateCategory,
    required this.submitExpense,
  });

  @override
  State<NewExpensePortrait> createState() {
    return _NewExpensePortraitState();
  }
}

class _NewExpensePortraitState extends State<NewExpensePortrait> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          maxLength: 50,
          decoration: const InputDecoration(
            label: Text('Title'),
          ),
          controller: widget.titleController,
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  prefixText: '\$ ',
                  label: Text('Amount'),
                ),
                controller: widget.amountController,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(widget.selectedDate == null
                      ? 'No date selected!'
                      : DateFormat.yMd().format(widget.selectedDate!)),
                  IconButton(
                    onPressed: widget.displayDatePicker,
                    icon: const Icon(Icons.calendar_month),
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            DropdownButton(
              value: widget.selectedCategory,
              items: Category.values
                  .map(
                    (category) => DropdownMenuItem(
                      value: category,
                      child: Text(
                        category.name.toUpperCase(),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: widget.updateCategory,
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            TextButton(
              onPressed: () => {
                Navigator.pop(context),
              },
              child: const Text('Cancel!'),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: widget.submitExpense,
              child: const Text('Save Expense'),
            ),
          ],
        )
      ],
    );
  }
}
