import 'package:expense_tracker/models/expense_data.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {

  // function keyword is used to define variable, parameter or return value is function.
  final Function (Expense) onAddExpense;
  const NewExpense({super.key, required this.onAddExpense});
  @override
  State<NewExpense> createState() {
    return _NewExpenseState(); //it has return type of state<newExpense>
  }
}

class _NewExpenseState extends State<NewExpense> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.lesiure;

  void _presentDayPicker() async {
    var now = DateTime.now();
    final initialDate = DateTime(now.year - 1, now.month, now.day);
    var pickedDate = await showDatePicker( // here show date picker is future type used async and await
        context: context,initialDate: now,firstDate: initialDate ,lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() async {
    final enterAmount = double.tryParse(_amountController.text);// convert string to double
    final amountIsInvalid = enterAmount == null || enterAmount <= 0;
    // trim :- string without leading and training white space
    if (_titleController.text.trim().toString().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
     await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Invalid Input"),
              content: const Text(
                  "Please make sure a valid title amount data and category are entered!"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"))
              ],
            );
          });
    } else {
      widget.onAddExpense(Expense(
          tittle: _titleController.text,
          amount: enterAmount,
          category: _selectedCategory,
          dateTime: _selectedDate!));
    }
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              maxLength: 50,
              controller: _titleController,
              decoration: const InputDecoration(label: Text("Title")),
            ),
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                  maxLength: 20,
                  controller: _amountController,
                  decoration: const InputDecoration(
                      prefixText: "\$", label: Text("Amount")),
                )),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // text as a place holder
                    Text(_selectedDate == null
                        ? "No date Selected"
                        : formatter.format(_selectedDate!)),
                    IconButton(
                        onPressed: _presentDayPicker,// present day picker used as a value
                        icon: const Icon(Icons.calendar_month))
                  ],
                ))
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                DropdownButton(
                    value: _selectedCategory,
                    // here we get all category value
                    items: Category.values.map((catergory) {
                      return DropdownMenuItem(
                        value: catergory,// select value by user
                        // name property used in enum to access enum value
                        child: Text(catergory.name.toUpperCase()),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          _selectedCategory = value;
                        });
                      });
                    }),
                const Spacer(),
                TextButton(
                    onPressed: Navigator.of(context).pop,
                    child: const Text('Cancel')),
                ElevatedButton(
                    onPressed: _submitExpenseData,
                    child: const Text('Save Expense'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
