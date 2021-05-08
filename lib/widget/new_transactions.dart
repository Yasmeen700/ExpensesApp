import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTransactions extends StatefulWidget {
  final Function addTransaction;

  AddTransactions(this.addTransaction);

  @override
  _AddTransactionsState createState() => _AddTransactionsState();
}

class _AddTransactionsState extends State<AddTransactions> {
  final amountController = TextEditingController();

  final nameController = TextEditingController();

  void submittedData() {
    final enteredAmount = double.parse(amountController.text);
    final enteredName = nameController.text;

    if (enteredName.isEmpty || enteredAmount <= 0) {
      return;
    }
    widget.addTransaction(enteredName, enteredAmount);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            controller: nameController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Name',
            ),
            onSubmitted: (_) => submittedData,
          ),
          TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => submittedData,
            decoration: InputDecoration(
              labelText: 'Amount',
            ),
          ),
          SizedBox(
            height: 5,
          ),
          ElevatedButton(
            onPressed: submittedData,
            child: Text('Add Transaction'),
          ),
        ],
      ),
    );
  }
}
