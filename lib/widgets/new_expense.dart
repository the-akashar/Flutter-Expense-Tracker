import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker_app/model/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense( {super.key, required this.onAddExpense}  );

  final void Function(Expense expense) onAddExpense ;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  // var _enteredTitle = '';

  // void _savedTitleInput(String inputValue){
  //   _enteredTitle = inputValue;
  // }

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final formatter = DateFormat.yMd();
  DateTime? _selectedDate ;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async{
    final now = DateTime.now();
    final firstDate = DateTime(now.year-1 , now.month ,now.day);
    final pickedDate = await showDatePicker(context: context,
     initialDate: now,
     firstDate: firstDate,
      lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }
  

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submitExpenseData(){
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0 ;
    if(_titleController.text.trim().isEmpty || amountIsInvalid || _selectedDate == null){
      showDialog(
        context: context, 
        builder: (ctx) => AlertDialog(
          title: const Text('Invslid Input'),
          content: Text("Please make a valid title amount date and category was entered"),
          actions: [
            TextButton(onPressed: () { Navigator.pop(ctx); }  , child: Text('Okay'))
          ],
        )
        );
        return;
    }
    widget.onAddExpense(
      Expense(
      title: _titleController.text,
      amount: enteredAmount,
      date: _selectedDate!,
      category: _selectedCategory
    ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const TextField(
            maxLength: 50,
            decoration: InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: const TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixText: '\$',
                        label: Text('Amount'),
                      ),
                    ),
                ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedDate == null ? 'No date selected' : formatter.format(_selectedDate!)),
                    IconButton(
                        onPressed: _presentDatePicker,
                        icon: const Icon(Icons.calendar_month))
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 16,),
          Row(
            children: [
              DropdownButton(
              value: _selectedCategory,
              items: Category.values.map(
                (calegory) => DropdownMenuItem(
                  value: calegory,
                  child: Text(calegory.name.toUpperCase(),),),
              ).toList(),
               onChanged: (value){
                if(value == null){
                  return;
                }
                setState(() {
                _selectedCategory = value;
                });
               }
               ),
               const Spacer(),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('cancel')),
              ElevatedButton(
                  onPressed: _submitExpenseData ,
                  child: const Text('Save Expense'))
            ],
          )
        ],
      ),
    );
  }
}
