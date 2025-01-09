import 'package:expense_tracker_app/model/expense.dart';
import 'package:expense_tracker_app/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget{

 const ExpensesList({super.key ,
  required this.expenses});

 final List<Expense> expenses ;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx , index) => ExpensesItem(expenses[index]),
      );
      
  }
}