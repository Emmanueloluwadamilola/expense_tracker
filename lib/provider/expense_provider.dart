import 'package:expense_tracker/expense_data.dart';
import 'package:expense_tracker/provider/expense_state.dart';
import 'package:flutter/material.dart';

class ExpenseProvider extends ChangeNotifier {
  final state = ExpenseState();

  addExpense() {
    state.myLIst.add(ExpenseModel(
        amount: state.expenseAmount,
        category: state.expenseCategory,
        date: state.date,
        title: state.expenseTitle));
    notifyListeners();
  }

  removeExpense(index) {
    if(state.deletedList.isNotEmpty){
      state.deletedList.removeAt(0);
    state.deletedList.add(state.myLIst[index]);
    state.myLIst.removeAt(index);
    notifyListeners();
    }
    else{
     
    state.deletedList.add(state.myLIst[index]);
    state.myLIst.removeAt(index);
    notifyListeners();

    }
    
  }

  setExpenseTitle(value) {
    state.expenseTitle = value;
    notifyListeners();
  }

  setExpenseAmount(value) {
    state.expenseAmount = value;
    notifyListeners();
  }

  setDate(value) {
    state.date = value;
    notifyListeners();
  }

  setExpenseCategory(value) {
    state.expenseCategory = value;
    notifyListeners();
  }
}
