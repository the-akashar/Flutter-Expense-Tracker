import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

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

  final _textController = TextEditingController();
  final _amountController = TextEditingController();

  void _presentDatePicker(){
    final now = DateTime.now();
    final firstDate = DateTime(now.year-1 , now.month ,now.day);
    showDatePicker(context: context,
     initialDate: now,
     firstDate: firstDate,
      lastDate: now);
  }

  @override
  void dispose() {
    _textController.dispose();
    _amountController.dispose();
    super.dispose();
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
                    const Text('Selected Date'),
                    IconButton(
                        onPressed: _presentDatePicker,
                        icon: const Icon(Icons.calendar_month))
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('cancel')),
              ElevatedButton(
                  onPressed: () {
                    // ignore: avoid_print
                    print(_textController.text);
                  },
                  child: const Text('Save Expense'))
            ],
          )
        ],
      ),
    );
  }
}
