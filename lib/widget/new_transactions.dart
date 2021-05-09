import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransactions extends StatefulWidget {
  final Function addTransaction;

  AddTransactions(this.addTransaction);

  @override
  _AddTransactionsState createState() => _AddTransactionsState();
}

class _AddTransactionsState extends State<AddTransactions> {
  final _amountController = TextEditingController();

  final _nameController = TextEditingController();
  DateTime _selectedDate;

  void _submittedData() {
    final enteredAmount = double.parse(_amountController.text);
    final enteredName = _nameController.text;

    if (enteredName.isEmpty || enteredAmount <= 0) {
      return;
    }
    widget.addTransaction(enteredName, enteredAmount);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() async {
    DateTime pickedDate;
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    );
    if (pickedDate == null) {
      return;
    }
    setState(() {
      _selectedDate = pickedDate;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            controller: _nameController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Name',
            ),
            onSubmitted: (_) => _submittedData,
          ),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _submittedData,
            decoration: InputDecoration(
              labelText: 'Amount',
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 70,
            child: Row(
              children: [
                Text(_selectedDate == null
                    ? 'No Date Chosen'
                    : DateFormat.yMd().format(_selectedDate)),
                SizedBox(
                  width: 10,
                ),
                TextButton(
                  onPressed: _presentDatePicker,
                  child: Text(
                    'Chose Date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _submittedData,
            child: Text('Add Transaction'),
          ),
        ],
      ),
    );
  }
}
