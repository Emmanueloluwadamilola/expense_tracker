// ignore_for_file: unused_field

import 'package:expense_tracker/expense_data.dart';

class ExpenseState {
  List<ExpenseModel> myLIst = [];
  List<ExpenseModel> deletedList = [];
  DateTime date = DateTime.now();
  String expenseTitle = '';
  double expenseAmount = 0.0;
  Category expenseCategory = Category.leisure;
}
