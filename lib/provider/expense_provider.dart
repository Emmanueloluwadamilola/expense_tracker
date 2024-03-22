import 'package:expense_tracker/provider/expense_state.dart';
import 'package:flutter/material.dart';

class ExpenseProvider extends ChangeNotifier {
  final state = ExpenseState();

  addExpense() {
    notifyListeners();
  }
}
