import 'package:expense_tracker_app/model/expense.dart';
import 'package:expense_tracker_app/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget{

  

 const ExpensesList({super.key ,
  required this.expenses , required this.onRemovedExpense});

 final List<Expense> expenses ;

 final void Function(Expense expense) onRemovedExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx , index) => Dismissible(
        key: ValueKey(expenses[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.5),
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal
          ),
        ),
        onDismissed: (direction){
          onRemovedExpense(expenses[index]);
        },
       child: ExpensesItem(
        expenses[index],
        ),
       ) ,
      );
      
  }
}