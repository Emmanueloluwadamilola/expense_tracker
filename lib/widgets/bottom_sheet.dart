import 'package:expense_tracker/expense_data.dart';
import 'package:expense_tracker/provider/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({super.key});

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  ExpenseProvider? _provider;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final now = DateTime.now();
  DateTime? selectedDate;
  Category selectedCategory = Category.leisure;
  double? amount;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submitExpenseData() {
    final amount = double.tryParse(_amountController.text);
    final amountIsInvalid = amount == null || amount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        selectedDate == null) {
      // const SnackBar(backgroundColor: Colors.red,
      //   content: Text('Invalid Input'));
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text('Enter valid title, amount or date'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      _provider?.addExpense();
      Navigator.pop(context);
    }
  }

  void displayDatePicker() async {
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      selectedDate = pickedDate;
      _provider?.setDate(selectedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
      builder: (context, provider, _) {
        _provider ??= provider;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  maxLength: 30,
                  decoration: const InputDecoration(
                    label: Text('Title'),
                  ),
                  onSubmitted: (value) => provider.setExpenseTitle(value),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        keyboardType:
                            const TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(
                          prefixText: '\$ ',
                          label: Text('Amount'),
                        ),
                        onSubmitted: (value) {
                          final amount = double.tryParse(value);
                          provider.setExpenseAmount(amount);
                        },
                      ),
                    ),
                    const Gap(5),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            selectedDate == null
                                ? 'Select Date'
                                : formatter.format(selectedDate!),
                          ),
                          IconButton(
                              onPressed: displayDatePicker,
                              icon: const Icon(Icons.calendar_month_outlined))
                        ],
                      ),
                    )
                  ],
                ),
                const Gap(10),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownButton(
                      value: selectedCategory,
                      items: Category.values
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(category.name.toUpperCase()),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          selectedCategory = value;
                          provider.setExpenseCategory(value);
                        });
                      },
                    ),
                    const Spacer(),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel')),
                    const Gap(5),
                    ElevatedButton(
                        onPressed: () {
                          _submitExpenseData();
                        },
                        child: const Text('Save Expense'))
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
