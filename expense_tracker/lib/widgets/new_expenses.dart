import 'package:flutter/material.dart';
import '../model/expense.dart';

class NewExpenses extends StatefulWidget {
  const NewExpenses({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpenses> createState() => _NewExpensesState();
}

class _NewExpensesState extends State<NewExpenses> {
  // this controller need to be disposed when it is not used else it occupies the memory in device
  final _textEditingController = TextEditingController();
  final _amountEditingContrller = TextEditingController();
  DateTime? _selectedDate;
  Categories _currentcategory = Categories.leisure;

  void _datePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final dataVal = await showDatePicker(
        context: context, firstDate: firstDate, lastDate: now);
    setState(() {
      _selectedDate = dataVal;
    });
  }

  void _summitExpensesData() {

    final enteredTtile = _textEditingController.text.trim();

    final enteredAmt = double.tryParse(_amountEditingContrller .text); //tryParse('Hello') => null tryParse('1.12') => 1.12

    final invalidAmt = enteredAmt == null || enteredAmt <= 0;

    // checking for Valid Inputs
    if (enteredTtile.isEmpty || invalidAmt || _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please make sure a valid title, amount, date and category was entered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    } 
  // Adding new expense if inputs are valid
    else {
      widget.onAddExpense(
        Expense(
            amount: enteredAmt,
            title: enteredTtile,
            date: _selectedDate!,
            category: _currentcategory),
      );
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    // disposed here
    _textEditingController.dispose();
    _amountEditingContrller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16,40,16,16),
      child: Column(
        children: [
          TextField(
            maxLength: 10,
            controller: _textEditingController,
            decoration: const InputDecoration(
                label: Text("Titile"),
                labelStyle:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  controller: _amountEditingContrller,
                  decoration: const InputDecoration(
                      prefixText: '\$ ',
                      label: Text("Amount"),
                      labelStyle:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(_selectedDate == null
                        ? "No date Seleted"
                        : formatter.format(_selectedDate!)),
                    IconButton(
                      icon: const Icon(
                        Icons.calendar_month_outlined,
                      ),
                      onPressed: _datePicker,
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              DropdownButton(
                // This value is shown in dropdown
                value: _currentcategory,
                items: Categories.values
                    .map(
                      (category) => DropdownMenuItem(
                        // This value is used by Onchanged so it is mandatory
                        value: category,
                        child: Text(category.name.toUpperCase()),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _currentcategory = value!;
                  });
                },
              ),
              const Spacer(),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancle"),
              ),
              ElevatedButton(
                onPressed: _summitExpensesData,
                child: const Text("Save Button"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
