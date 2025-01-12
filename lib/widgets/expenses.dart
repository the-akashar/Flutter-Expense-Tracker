import 'package:expense_tracker_app/widgets/charts/chart.dart';
import 'package:expense_tracker_app/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker_app/model/expense.dart';
import 'package:expense_tracker_app/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses>{

final List<Expense> _registeredExpenses = [
  Expense(title: 'Flutter Course', amount: 19.99, date: DateTime.now(), category: Category.work),
  Expense(title: 'Cinema', amount: 15.69, date: DateTime.now(), category: Category.leisure),
];

void _openAddExpensesOverlay(){
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (ctx) => NewExpense(onAddExpense: _addExpense)
  );
}

void _addExpense(Expense expense){
  setState((){
    _registeredExpenses.add(expense);
  }
  );
}

void _removeExpense(Expense expense){
  final expenseInsex = _registeredExpenses.indexOf(expense);
  setState(() {
    _registeredExpenses.remove(expense);
  });
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 2),
      content: const Text('Expense Deleted'),
      action: SnackBarAction(
      label: "Undo", 
      onPressed: (){
        setState(() {
          _registeredExpenses.insert(expenseInsex, expense);
        });
      })),
    );
}

  @override
  Widget build(BuildContext context) {

    Widget mainContent = const Center(
      child: Text('No expenses found start adding some!!!'),
    );

    if(_registeredExpenses.isNotEmpty){
      mainContent = ExpensesList(expenses:_registeredExpenses, onRemovedExpense: _removeExpense,
          );
    }


    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
          onPressed: _openAddExpensesOverlay, 
          icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Chart(expenses:_registeredExpenses),
          Expanded(child: mainContent)
        ],
      ),
    );
  }
  
}