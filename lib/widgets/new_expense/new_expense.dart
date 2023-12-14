import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/utils/helpers.dart';
import 'package:expense_tracker/widgets/new_expense/new_expense_landscape.dart';
import 'package:expense_tracker/widgets/new_expense/new_expense_portrait.dart';
import 'package:flutter/material.dart';

import '../../dictionary/category.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _displayDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _updateCategory(Category? selectedCategory) {
    if (selectedCategory == null) {
      return;
    }
    setState(() {
      _selectedCategory = selectedCategory;
    });
  }

  void _submitExpense() {
    final enteredAmount = double.tryParse(_amountController.text);
    final isAmountInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        isAmountInvalid ||
        _selectedDate == null) {
      Helpers.showNativeDialog(
        context,
        const Text('Invalid input!'),
        const Text('Please make sure to enter valid values'),
        (ctx) {
          return [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ];
        },
      );

      return;
    }

    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardHeight + 16),
            child: width < 600
                ? NewExpensePortrait(
                    titleController: _titleController,
                    amountController: _amountController,
                    selectedCategory: _selectedCategory,
                    displayDatePicker: _displayDatePicker,
                    updateCategory: _updateCategory,
                    submitExpense: _submitExpense,
                  )
                : NewExpenseLandscape(
                    titleController: _titleController,
                    amountController: _amountController,
                    selectedCategory: _selectedCategory,
                    displayDatePicker: _displayDatePicker,
                    updateCategory: _updateCategory,
                    submitExpense: _submitExpense,
                  ),
          ),
        ),
      );
    });
  }
}
